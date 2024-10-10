<?php

namespace App\Http\Controllers\Candidate;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Auth; 
use Illuminate\Support\Facades\Validator; 
use DB;
use Illuminate\Support\Facades\Hash;
use Carbon\Carbon;
use App\Models\Question;  // Model for questions table
use App\Models\Participant; // Model for participant table

class Validate extends Controller
{
    public function ValidateUser(Request $request)
    {
        $request->validate([
            'category' => 'required',
            'username' => 'required',
            'birthdate' => 'required|date', // Ensure the date is valid
        ]);
        
        // Retrieve the input values
        $quizName = $request->input('category');
        $applicationId = $request->input('username');
        $birthdate = $request->input('birthdate');

        // Construct the table name dynamically
        $participantsTable = $quizName . '_participants';
        $questionsTable = $quizName . '_questions';

        // Check if the application ID exists and if the date of birth matches
        $participant = DB::table($participantsTable)
            ->where('application_id', $applicationId)
            ->where('dob', $birthdate)
            ->first();

        if (!$participant) {
            return redirect()->back()->withErrors(['error' => 'Invalid Application ID or Date of Birth.']);
        }

        // Fetch the test length from the quizzes table
        $quiz = DB::table('quizzes')->where('quiz_name', $quizName)->first();

        if (!$quiz) {
            return redirect()->back()->withErrors(['error' => 'Quiz not found.']);
        }

        if($participant->attempted == 1)
            return redirect('/')->withErrors(['error' => 'Test Already Attempted']);

        // Calculate the end time by adding test_length minutes to the current time
        $timezone = 'Asia/Kolkata';
        $testLength = $quiz->test_length; // Assume test_length is in minutes

        // Get the current time in the specified timezone
        $currentTime = Carbon::now($timezone);

        // Calculate the end time by adding test length to the current time
        $endTime = $currentTime->copy()->addMinutes($testLength);

        // Convert the quiz start time from UTC to the specified timezone
        $startTime = Carbon::parse($quiz->start_time)->timezone($timezone);
        $EndTestTime = Carbon::parse($quiz->end_time)->timezone($timezone);

        // Check if endtime already exists for the participant
        

        // Fetch questions from the respective questions table
        
        
        // Redirect to the quiz page with the questions
        Session::put('candidate', $participant);
        if($startTime <= $currentTime && $EndTestTime > $currentTime)
        {
            if (is_null($participant->endtime))
            {
                // Update the participant's record with the end time only if it is not set
                DB::table($participantsTable)
                    ->where('application_id', $applicationId)
                    ->update(['endtime' => $endTime]);
                
                $questions = DB::table($questionsTable)->inRandomOrder()->get();
                Session::put('questions', $questions);
            } else {
                // If endtime is already set, fetch it from the participant record
                $endTime = $participant->endtime;
            }
        }
        else
        {
            $endTime=NULL;
        }
        return view('Candidate.Quiz', [
            // 'questions' => $questions,
            'endTime' => $endTime,
            'applicationId' => $applicationId,
            'QuestionTable' => $questionsTable,
            'ParticipantsTable' => $participantsTable,
            'participant' => $participant,
            'quiz' => $quiz,
        ]);
    }

    public function submitQuiz(Request $request)
    {
        // Retrieve participant's answers from the form
        $answers = $request->except('_token'); // Exclude the CSRF token from the request data
        $totalScore = 0; // Initialize score
    
        // Loop through each answer to check against correct answers
        foreach ($answers as $questionKey => $selectedAnswer) {
            // Define an array of keys to ignore (those that contain specific identifiers or patterns)
            $ignoreKeys = ['applicationId', 'QuestionTable', 'ParticipantsTable']; // Replace with actual hidden input names
        
            // Check if the current key is in the ignore list
            if (in_array($questionKey, $ignoreKeys)) {
                continue; // Skip this iteration if it's a key to ignore
            }
        
            // Ensure the questionKey contains an underscore and split it
            if (strpos($questionKey, '_') !== false) {
                // Extract the question ID from the input name, assuming the format is 'question_{id}'
                $parts = explode('_', $questionKey);
        
                // Check if the array has two parts and proceed
                if (count($parts) === 2) {
                    $questionId = $parts[1];
        
                    // Find the correct answer for the question
                    $question = DB::table($request->QuestionTable)->where('id', $questionId)->first();
    
                    // Compare the user's answer with the correct answer (assuming 'ans' is the correct option)
                    if ($question && $selectedAnswer == $question->ans) {
                        $totalScore++; // Increment score for correct answers
                    }
                }
            }
        }
    
        // Update the participant's score
        DB::table($request->ParticipantsTable)->where('application_id', $request->applicationId)->update([
            'score' => $totalScore,
            'attempted' => 1,
        ]);
    
        // Destroy the session
        Session::flush();
    
        // Redirect to the thank you page
        return redirect()->route('thanksPage'); // Pass the score to the next page if needed
    }
    

    public function showThanksPage()
    {
        return view('Candidate.ThankYou'); // Render the thanks view
    }
}
