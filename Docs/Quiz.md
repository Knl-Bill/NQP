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
Constructs table names dynamically based on test name. `$questionsTable` table is used to store the questions, associated options and the correct answer of the question, whereas on the other hand, the `$participantsTable` is used to store the ApplicationID, DOB, score, and endtime for the users.

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
This code snippet is part of a function that verifies whether a participant is valid based on their application ID and date of birth. Here's a breakdown of what it does:

### Database Query:
It queries a dynamically determined database table, $participantsTable, which is expected to contain participant data related to a specific quiz or category.
It uses the `DB::table()` method to initiate a query on that table.

### Where Clauses:
The where method is used to specify two conditions for the query:
The first condition checks if the application_id matches the provided `$applicationId`.
The second condition checks if the dob (date of birth) matches the provided `$birthdate`.

### Fetch the First Record:
The `first()` method retrieves the first record that meets the specified conditions. If no matching record is found, it will return null.

### Check for Existence:
The code then checks if the `$participant` variable is null, which indicates that no record was found matching the application ID and date of birth provided.
If the record does not exist, the function redirects the user back to the previous page (usually the form they submitted) and includes an error message stating "Invalid Application ID or Date of Birth." This informs the user that their input does not correspond to any participant in the database.

## Fetch Quiz:
```php
        $quiz = DB::table('quizzes')->where('quiz_name', $quizName)->first();

        if (!$quiz) {
            return redirect()->back()->withErrors(['error' => 'Quiz not found.']);
        }

        if($participant->attempted == 1)
            return redirect('/')->withErrors(['error' => 'Test Already Attempted']);
```
This code snippet is part of a function that checks for the existence of a quiz and whether a participant has already attempted it. Here’s a breakdown of what it does:

### Quiz Query:
The code queries the quizzes table in the database using the `DB::table()` method. It searches for a quiz where the `quiz_name` matches the value of the variable `$quizName`.
The `first()` method is used to retrieve the first record that matches this condition. If no matching quiz is found, it will return null.

### Check for Quiz Existence:
The code then checks if the `$quiz` variable is null, which indicates that there is no quiz in the database with the specified name.
If the quiz is not found, the function redirects the user back to the previous page (typically the form they submitted) and includes an error message: "Quiz not found." This informs the user that their attempt to access a quiz that does not exist is invalid.

### Check if Test Already Attempted:
After confirming that the quiz exists, the code checks if the participant (represented by the `$participant` variable) has already attempted the quiz by checking the attempted field.
If attempted is equal to 1, it means that the participant has already taken the test. In this case, the code redirects the user to the home page ('/') with another error message: "Test Already Attempted." This informs the user that they cannot retake the quiz they have already completed.

## Calculate End Time:
```php
        $timezone = 'Asia/Kolkata';
        $testLength = $quiz->test_length; // Assume test_length is in minutes

        $currentTime = Carbon::now($timezone);
        $endTime = $currentTime->copy()->addMinutes($testLength);

        $startTime = Carbon::parse($quiz->start_time)->timezone($timezone);
        $EndTestTime = Carbon::parse($quiz->end_time)->timezone($timezone);
```
This code snippet is responsible for handling time-related operations in the context of a quiz application.

### Set Timezone:

```php
$timezone = 'Asia/Kolkata';
```
This line defines the timezone variable as 'Asia/Kolkata'. This is used to ensure that all time calculations are consistent with the specified timezone, particularly for users located in that region.
Retrieve Test Length:

```php
$testLength = $quiz->test_length; // Assume test_length is in minutes
```
Here, the code retrieves the length of the quiz (in minutes) from the $quiz object. This value is expected to be defined in the database and indicates how long participants have to complete the quiz.
Get Current Time:

```php
$currentTime = Carbon::now($timezone);
```
This line uses the Carbon library to obtain the current time, adjusted to the 'Asia/Kolkata' timezone. Carbon is a PHP library for date and time manipulation, making it easier to handle time-related operations.
Calculate End Time:

```php
$endTime = $currentTime->copy()->addMinutes($testLength);
```
The copy() method is used to create a clone of the current time to avoid modifying the original $currentTime variable.
The addMinutes($testLength) method adds the quiz's length (in minutes) to the current time to calculate the endTime. This represents the point in time when the quiz will automatically be considered as completed, marking the end of the participant's available time to finish the quiz.

### Parse Start Time:
```php
$startTime = Carbon::parse($quiz->start_time)->timezone($timezone);
```
This line parses the start_time from the $quiz object, which is typically stored in the database in UTC or another standard format. The timezone($timezone) method adjusts this time to the specified 'Asia/Kolkata' timezone. As a result, startTime reflects when the quiz is supposed to start in the correct timezone.

### Parse End Test Time:
```php
$EndTestTime = Carbon::parse($quiz->end_time)->timezone($timezone);
```
Similarly, this line parses the end_time from the $quiz object and adjusts it to the specified timezone. This represents the official end time for the quiz as set in the system.

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
This code section prepares the quiz session for a candidate by storing necessary data in the session, checking quiz timings, updating the end time if necessary, and loading quiz questions. Here’s a detailed breakdown of each part:

1. **Store Candidate in Session**:
   ```php
   Session::put('candidate', $participant);
   ```
   - This line saves the `$participant` object to the session under the key `'candidate'`. This stores the participant’s information temporarily, making it accessible throughout the quiz session.

2. **Check Quiz Timing**:
   ```php
   if($startTime <= $currentTime && $EndTestTime > $currentTime)
   ```
   - This `if` statement checks whether the current time (`$currentTime`) falls within the quiz's allowed time period. It ensures that:
     - The current time is after or at the quiz start time (`$startTime`).
     - The current time is before the quiz end time (`$EndTestTime`).
   - Only if both conditions are met can the participant proceed with the quiz.

3. **Set End Time and Retrieve Questions**:
   ```php
   if (is_null($participant->endtime))
   ```
   - This nested `if` checks if the participant’s `endtime` is not set (`null`).
   - If it’s `null`, it means the participant is starting the quiz for the first time, so it does the following:
     - **Update Participant’s End Time**:
       ```php
       DB::table($participantsTable)
           ->where('application_id', $applicationId)
           ->update(['endtime' => $endTime]);
       ```
       - This updates the participant's record in the database with the calculated `endTime` (derived earlier), establishing the time limit by which the participant must complete the quiz.
     - **Retrieve Quiz Questions**:
       ```php
       $questions = DB::table($questionsTable)->inRandomOrder()->get();
       ```
       - This fetches all questions from the specified questions table (`$questionsTable`), randomizes their order with `inRandomOrder()`, and retrieves them as a collection.
     - **Store Questions in Session**:
       ```php
       Session::put('questions', $questions);
       ```
       - The questions are stored in the session under the key `'questions'` to be displayed to the participant during the quiz.
   
   - **If End Time Already Set**:
     ```php
     else {
         $endTime = $participant->endtime;
     }
     ```
     - If `endtime` is already set (i.e., the participant has already started the quiz but not completed it), the code retrieves this previously set `endtime` from the participant’s record to maintain the original quiz duration for this session.

4. **Handle Out-of-Time Cases**:
   ```php
   else {
       $endTime = NULL;
   }
   ```
   - If the current time is outside the allowed quiz period (either too early or too late), the code sets `$endTime` to `NULL`, effectively marking the quiz as inaccessible.

5. **Render Quiz View**:
   ```php
   return view('Candidate.Quiz', [
       'endTime' => $endTime,
       'applicationId' => $applicationId,
       'QuestionTable' => $questionsTable,
       'ParticipantsTable' => $participantsTable,
       'participant' => $participant,
       'quiz' => $quiz,
   ]);
   ```
   - This final line returns the `Candidate.Quiz` view (which represents the quiz page) with the following data passed:
     - `'endTime'`: the participant’s end time for the quiz or `NULL` if the quiz is not accessible.
     - `'applicationId'`: the participant’s application ID.
     - `'QuestionTable'` and `'ParticipantsTable'`: the names of the questions and participants tables, respectively.
     - `'participant'`: the participant’s data.
     - `'quiz'`: the quiz details.
     - 
This code manages quiz access by verifying quiz timings, saving the end time for first-time participants, and storing randomized questions for the session. If the quiz is unavailable (due to timing restrictions), it restricts access accordingly.

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
This function, `submitQuiz`, processes and evaluates a participant’s quiz submission, calculates their score, and updates their results in the database. Here’s a detailed breakdown of how it works:

1. **Retrieve Answers from the Request**:
   ```php
   $answers = $request->except('_token');
   ```
   - This line extracts all submitted answers from the request, excluding the CSRF token (`_token`), which is a security measure in form submissions. This leaves only the question responses and other necessary data in `$answers`.

2. **Initialize Counters**:
   ```php
   $totalScore = 0;
   $totalQuestions = DB::table($request->QuestionTable)->count();
   $wrongAnswers = 0;
   $unansweredQuestions = 0;
   ```
   - The code initializes several counters:
     - `$totalScore`: Tracks the number of correct answers.
     - `$totalQuestions`: Fetches the total number of questions from the specified questions table.
     - `$wrongAnswers`: Tracks the number of incorrect answers.
     - `$unansweredQuestions`: Tracks the number of unanswered questions.

3. **Iterate Through Answers**:
   ```php
   foreach ($answers as $questionKey => $selectedAnswer)
   ```
   - This loop iterates over each answer in `$answers`, where `$questionKey` is the name of the question field, and `$selectedAnswer` is the participant’s submitted answer.

4. **Skip Non-Question Keys**:
   ```php
   $ignoreKeys = ['applicationId', 'QuestionTable', 'ParticipantsTable'];
   if (in_array($questionKey, $ignoreKeys)) {
       continue;
   }
   ```
   - The code checks if `$questionKey` is in `$ignoreKeys`, which contains metadata fields like `'applicationId'`, `'QuestionTable'`, and `'ParticipantsTable'`. If it’s one of these, the iteration skips to the next answer.

5. **Extract Question ID**:
   ```php
   if (strpos($questionKey, '_') !== false) {
       $parts = explode('_', $questionKey);
       if (count($parts) === 2) {
           $questionId = $parts[1];
   ```
   - For each question, the code checks if `$questionKey` contains an underscore (`'_'`). If so, it splits `$questionKey` by `_`, and if the resulting array has two parts, it extracts the `questionId` (assumed to be the second part of `$questionKey`).

6. **Fetch Question from Database and Evaluate**:
   ```php
   $question = DB::table($request->QuestionTable)->where('id', $questionId)->first();
   ```
   - The code retrieves the question with the given `questionId` from the specified questions table.
   - If the question exists:
     - **Check if Unanswered**:
       ```php
       if (empty($selectedAnswer)) {
           $unansweredQuestions++;
       ```
       - If `$selectedAnswer` is empty, it increments the `$unansweredQuestions` counter.
     - **Check if Correct or Incorrect**:
       ```php
       } else if ($selectedAnswer == $question->ans) {
           $totalScore++;
       } else {
           $wrongAnswers++;
       }
       ```
       - If the answer matches the correct answer (`$question->ans`), `$totalScore` is incremented.
       - Otherwise, `$wrongAnswers` is incremented.

7. **Update Participant’s Score in Database**:
   ```php
   DB::table($request->ParticipantsTable)->where('application_id', $request->applicationId)->update([
       'score' => $totalScore,
       'attempted' => 1,
       'wrong' => $wrongAnswers,
       'unanswered' => $totalQuestions - $totalScore - $wrongAnswers,
   ]);
   ```
   - After evaluating all answers, the code updates the participant’s record in the specified participants table:
     - `'score'`: Sets it to `$totalScore` (number of correct answers).
     - `'attempted'`: Sets it to `1`, indicating the participant has completed the quiz.
     - `'wrong'`: Sets it to `$wrongAnswers`.
     - `'unanswered'`: Sets it to the count of unanswered questions, calculated as the difference between `totalQuestions`, `totalScore`, and `wrongAnswers`.

8. **Clear Session and Redirect**:
   ```php
   Session::flush();
   return redirect()->route('thanksPage');
   ```
   - The code clears the session data to end the quiz session and redirects the participant to a thank-you page (or a completion page). 

### In short the `submitQuiz` function:
1. Processes the quiz answers and evaluates correctness.
2. Tracks correct, incorrect, and unanswered questions.
3. Updates the participant’s score and attempt status in the database.
4. Clears the session and redirects the user to a completion page.

## showThanksPage Method
```php
    public function showThanksPage()
    {
        return view('Candidate.ThankYou'); // Render the thanks view
    }
}
```
Displays the thank-you page after the quiz submission.
