# Validate Controller Documentation
## Namespace and Imports
```php
namespace App\Http\Controllers\Candidate;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Auth; 
use Illuminate\Support\Facades\Validator; 
use DB;
use Illuminate\Support\Facades\Hash;
use Carbon\Carbon;
use App\Models\Question;  
use App\Models\Participant; 
```
Namespace: Defines the namespace for the controller.
Imports: Imports various classes and functions used in the controller, including Session, Auth, Validator, DB, Hash, Carbon, and the models Question and Participant.

## Validate Class Definition
```php
class Validate extends Controller
{
```
Defines the Validate class which extends the Controller class.

## ValidateUser Method
```php
    public function ValidateUser(Request $request)
    {
```
Defines the ValidateUser method which takes an HTTP request as a parameter.

## Validation:
```php
        $request->validate([
            'category' => 'required',
            'username' => 'required',
            'birthdate' => 'required|date', // Ensure the date is valid
        ]);
```
Validates the input fields category, username, and birthdate.

## Retrieve Input Values:
```php
        $quizName = $request->input('category');
        $applicationId = $request->input('username');
        $birthdate = $request->input('birthdate');
```
Retrieves the input values from the request.

## Dynamic Table Names:
```php
        $participantsTable = $quizName . '_participants';
        $questionsTable = $quizName . '_questions';
```
Constructs table names dynamically based on test name

## Check Participant:
```php
        $participant = DB::table($participantsTable)
            ->where('application_id', $applicationId)
            ->where('dob', $birthdate)
            ->first();

        if (!$participant) {
            return redirect()->back()->withErrors(['error' => 'Invalid Application ID or Date of Birth.']);
        }
```
Checks if the participant exists with the provided application ID and birthdate. Redirects back with an error message if the participant is not found.

## Fetch Quiz:
```php
        $quiz = DB::table('quizzes')->where('quiz_name', $quizName)->first();

        if (!$quiz) {
            return redirect()->back()->withErrors(['error' => 'Quiz not found.']);
        }

        if($participant->attempted == 1)
            return redirect('/')->withErrors(['error' => 'Test Already Attempted']);
```
Fetches the quiz details. Redirects back with an error message if the quiz is not found or if the participant has already attempted the test.

## Calculate End Time:
```php
        $timezone = 'Asia/Kolkata';
        $testLength = $quiz->test_length; // Assume test_length is in minutes

        $currentTime = Carbon::now($timezone);
        $endTime = $currentTime->copy()->addMinutes($testLength);

        $startTime = Carbon::parse($quiz->start_time)->timezone($timezone);
        $EndTestTime = Carbon::parse($quiz->end_time)->timezone($timezone);
```
Calculates the end time for the test by adding the test length to the current time.

## Update Participant End Time:
```php
        Session::put('candidate', $participant);
        if($startTime <= $currentTime && $EndTestTime > $currentTime)
        {
            if (is_null($participant->endtime))
            {
                DB::table($participantsTable)
                    ->where('application_id', $applicationId)
                    ->update(['endtime' => $endTime]);
                
                $questions = DB::table($questionsTable)->inRandomOrder()->get();
                Session::put('questions', $questions);
            } else {
                $endTime = $participant->endtime;
            }
        }
        else
        {
            $endTime=NULL;
        }
        return view('Candidate.Quiz', [
            'endTime' => $endTime,
            'applicationId' => $applicationId,
            'QuestionTable' => $questionsTable,
            'ParticipantsTable' => $participantsTable,
            'participant' => $participant,
            'quiz' => $quiz,
        ]);
    }
```
Updates the participant's end time if not already set, fetches the questions, and redirects to the quiz page with relevant data.

## submitQuiz Method
```php
    public function submitQuiz(Request $request)
    {
        $answers = $request->except('_token'); // Exclude the CSRF token from the request data
        $totalScore = 0; // Initialize score
        $totalQuestions = DB::table($request->QuestionTable)->count(); // Initialize the total number of questions
        $wrongAnswers = 0; // Initialize wrong answers count
        $unansweredQuestions = 0; // Initialize unanswered questions count

        foreach ($answers as $questionKey => $selectedAnswer) {
            $ignoreKeys = ['applicationId', 'QuestionTable', 'ParticipantsTable']; // Replace with actual hidden input names

            if (in_array($questionKey, $ignoreKeys)) {
                continue; // Skip this iteration if it's a key to ignore
            }

            if (strpos($questionKey, '_') !== false) {
                $parts = explode('_', $questionKey);

                if (count($parts) === 2) {
                    $questionId = $parts[1];

                    $question = DB::table($request->QuestionTable)->where('id', $questionId)->first();

                    if ($question) {
                        if (empty($selectedAnswer)) {
                            $unansweredQuestions++; // Increment unanswered questions count
                        } else if ($selectedAnswer == $question->ans) {
                            $totalScore++; // Increment score for correct answers
                        } else {
                            $wrongAnswers++; // Increment wrong answers count
                        }
                    }
                }
            }
        }

        DB::table($request->ParticipantsTable)->where('application_id', $request->applicationId)->update([
            'score' => $totalScore,
            'attempted' => 1,
            'wrong' => $wrongAnswers,
            'unanswered' => $totalQuestions - $totalScore - $wrongAnswers,
        ]);

        Session::flush();

        return redirect()->route('thanksPage');
    }
```
Handles the quiz submission, checks answers, calculates score, and updates participant's record. Then redirects to the thank you page.

## showThanksPage Method
```php
    public function showThanksPage()
    {
        return view('Candidate.ThankYou'); // Render the thanks view
    }
}
```
Displays the thank-you page after the quiz submission.
