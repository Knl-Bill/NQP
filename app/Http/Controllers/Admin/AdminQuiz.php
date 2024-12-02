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
