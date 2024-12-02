<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Auth; 
use Illuminate\Support\Facades\Validator; 
use DB;
use Illuminate\Support\Facades\Hash;
use Symfony\Component\HttpFoundation\Response;

class AdminQuiz extends Controller
{
    //
    public function AdminDashboard()
    {
        $admin = Session::get('admin');
        if($admin)
            return view('Admin.create', ['user' => $admin]);
        return redirect()->route('AdminLoginPage');
    }
    public function DeleteQuizPage()
    {
        $admin = Session::get('admin');
        if($admin)
        {
            $quiz = DB::table('quizzes')->get();
            return view('Admin.delete', ['user' => $admin, 'quiz' => $quiz]);
        }
        return redirect()->route('AdminLoginPage');
    }
    public function deleteQuiz(Request $request)
    {
        // Validate the request to ensure the quiz name is provided
        $request->validate([
            'quiz_name' => 'required|string',
        ]);

        try {
            // Define the table names dynamically based on quiz_name
            $participantsTable = "{$request->quiz_name}_participants";
            $questionsTable = "{$request->quiz_name}_questions";

            // Delete the participants table if it exists
            if (DB::getSchemaBuilder()->hasTable($participantsTable)) {
                DB::statement("DROP TABLE IF EXISTS {$participantsTable}");
            }

            // Delete the questions table if it exists
            if (DB::getSchemaBuilder()->hasTable($questionsTable)) {
                DB::statement("DROP TABLE IF EXISTS {$questionsTable}");
            }

            // Delete the entry in the quizzes table with the matching quiz_name
            DB::table('quizzes')->where('quiz_name', $request->quiz_name)->delete();

            // Redirect back with a success message
            return redirect()->back()->with('success', 'Quiz and related data deleted successfully!');
        } catch (\Exception $e) {
            // Log the error
            \Log::error('Failed to delete quiz: ' . $e->getMessage());

            // Redirect back with an error message
            return redirect()->back()->withErrors(['message' => 'Failed to delete quiz. Please try again later.']);
        }
    }
    public function ResultsPage()
    {
        $admin = Session::get('admin');
        if($admin)
        {
            $quiz = DB::table('quizzes')->get();
            return view('Admin.result', ['user' => $admin, 'quiz' => $quiz]);
        }
        return redirect()->route('AdminLoginPage');
    }
    public function GetResults(Request $request)
    {
        $admin = Session::get('admin');
        if(!$admin)
            return redirect('AdminLoginPage');
        // Validate the quiz name
        $request->validate([
            'quiz_name' => 'required|exists:quizzes,quiz_name',
        ]);

        // Create the participants table name
        $participantsTable = "{$request->quiz_name}_participants";

        // Check if the table exists
        if (!DB::getSchemaBuilder()->hasTable($participantsTable)) {
            return response()->json(['error' => 'Participants table not found.'], 404);
        }

        // Retrieve application_id and score from the participants table where score is not null
        $participants = DB::table($participantsTable)
            ->select('application_id', 'score', 'wrong', 'unanswered')
            ->whereNotNull('score') // Only include rows where score is not null
            ->get();

        // Check if there are participants
        if ($participants->isEmpty()) {
            return response()->json(['error' => 'No participants found for this quiz.'], 404);
        }

        // Generate CSV file name
        $csvFileName = "{$request->quiz_name}_participants.csv";

        // Set headers for the response
        $headers = [
            "Content-type" => "text/csv",
            "Content-Disposition" => "attachment; filename={$csvFileName}",
        ];

        // Open output stream for writing
        $handle = fopen('php://output', 'w');

        // Output CSV header
        fputcsv($handle, ['Application ID', 'Score', 'Wrong Answers', 'Unanswered']); // CSV Header

        // Output participant data
        foreach ($participants as $participant) {
            fputcsv($handle, [$participant->application_id, $participant->score, $participant->wrong, $participant->unanswered]);
        }

        // Flush output to the browser
        fflush($handle);

        // Close the output stream (This should be done after all data is sent)
        fclose($handle);

        // Return the response as a CSV download
        return response()->stream(function () {
            // No additional processing is needed here
        }, Response::HTTP_OK, $headers);
    }
    public function EditQuizPage()
    {
        $admin = Session::get('admin');
        if($admin)
        {
            $quiz = DB::table('quizzes')->get();
            return view('Admin.editquiz', ['user' => $admin, 'quiz' => $quiz]);
        }
        return redirect()->route('AdminLoginPage');
        
    }
    public function EditQuiz(Request $request)
    {
        $request->validate([
            'quiz_name' => 'required|exists:quizzes,quiz_name',
        ]);
        $participantsTable = "{$request->quiz_name}_participants";
        $participants = DB::table($participantsTable)->get();
        return view('Admin.resetquiz', ['participants' => $participants, 'selectedQuiz' => $request->quiz_name]);
    }
    public function ResetQuiz(Request $request, $id)
    {
        $request->validate([
            'quiz_name' => 'required|exists:quizzes,quiz_name',
        ]);
        
        $participantsTable = "{$request->quiz_name}_participants";
        $candidate = DB::table($participantsTable)->select('application_id')->where('id', $id)->first();
        
        DB::table($participantsTable)->where('id', $id)->update([
            'attempted' => null,
            'endtime' => null,
        ]);
        
        return redirect()->route('EditQuizPage')->with(['success' => "Test has been reset for {$candidate->application_id}", 'quiz_name' => $request->quiz_name]);
    }
    public function ResetQuizBulk(Request $request, $applicationIds)
    {
        $request->validate([
            'quiz_name' => 'required|exists:quizzes,quiz_name',
        ]);
        $applicationIdsArray = explode(',', $applicationIds);
        $participantsTable = "{$request->quiz_name}_participants";
        $resetApplicationIds = [];
        foreach ($applicationIdsArray as $applicationId) {
            $participant = DB::table($participantsTable)->where('application_id', $applicationId)->first();

            if ($participant) {
                DB::table($participantsTable)->where('application_id', $applicationId)->update([
                    'attempted' => null,
                    'endtime' => null,
                ]);
                $resetApplicationIds[] = $applicationId;
            }
        }
        if (count($resetApplicationIds) > 0) {
            return redirect()->route('EditQuizPage')->with([
                'success' => "Tests have been reset for the selected participants: " . implode(', ', $resetApplicationIds),
                'quiz_name' => $request->quiz_name,
            ]);
        }
        return redirect()->route('EditQuizPage')->with([
            'error' => 'No valid participants were found for the reset operation.',
            'quiz_name' => $request->quiz_name,
        ]);
    }

    public function resetSelectedTests(Request $request)
    {
        // Validate the request
        $request->validate([
            'participant_ids' => 'required|array|min:1',
            'participant_ids.*' => 'exists:participants,id', // Validate that each ID exists in the participants table
            'quiz_name' => 'required|exists:quizzes,quiz_name', // Ensure the quiz name exists
        ]);

        $participantIds = $request->input('participant_ids');
        $quizName = $request->input('quiz_name');

        $participantsTable = "{$quizName}_participants";

        // Fetch application IDs for the success message
        $candidates = DB::table($participantsTable)
                        ->whereIn('id', $participantIds)
                        ->pluck('application_id');

        // Perform the bulk update
        DB::table($participantsTable)
            ->whereIn('id', $participantIds)
            ->update([
                'attempted' => null,
                'endtime' => null,
            ]);

        // Prepare success message
        $candidateList = implode(', ', $candidates->toArray()); // Convert array to comma-separated string

        // Redirect back with success message
        return redirect()->route('EditQuizPage')
                        ->with('success', "Test has been reset for participants: {$candidateList}")
                        ->with('quiz_name', $quizName);
    }



    public function AdminLoginPage()
    {
        return view('Admin.AdminLogin');
    }
    public function AdminLogin(Request $request)
    {
        // Step 1: Validate the input
        $validator = Validator::make($request->all(), [
            'email' => 'required|email|exists:users',
            'password' => 'required|min:8'
        ]);

        // Step 2: If validation fails, redirect back with errors
        if($validator->fails()) 
        {
            return redirect()->back()->withErrors($validator)->withInput();
        }
        
        $email = $request->input('email');
        $password = $request->input('password');
        $QuizType = DB::table('quiztype')->get();
        // Retrieve the user by their phone number
        $user = DB::table('users')->where('email', $email)->first();
        if($user) 
        {
            // If the user exists, check if the password matches
            if(HASH::check($password,$user->password)) 
            {
                // Password matches, redirect to dashboard
                Session::put('admin',$user);
                Session::put('QuizType', $QuizType);
                return view('Admin.create', ['user'=> $user]);
            } 
            else 
            {
                // Password does not match, show error message
                return back()->withInput()->withErrors(['password' => 'Wrong Password!']);
            }
        } 
        else 
        {
            // User not found, show error message
            return back()->withInput()->withErrors(['email' => 'User does not Exist!']);
        }
    }
    public function AdminLogout()
    {
        Session::forget('admin');
        Session::forget('QuizType');
        Auth::logout();

        // Redirect to the login page
        return redirect()->route('AdminLoginPage');
    }
}
