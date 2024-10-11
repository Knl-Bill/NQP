<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB; // Import the DB facade for raw queries
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Maatwebsite\Excel\Facades\Excel;
use App\Imports\QuestionsImport;
use App\Imports\ParticipantsImport;
use Carbon\Carbon;

class QuizController extends Controller
{
    public function CreateNewQuiz(Request $request) // Ensure to include Request as a parameter
    {
        // Validate the incoming request data
        $request->validate([
            'quiz_name' => 'required|string|max:255',
            'quiz_length' => 'required|integer|min:1',
            'start_time' => 'required|date',
            'end_time' => 'required|date|after:start_time',
            'questions_file' => 'required|file|mimes:csv,xlsx',
            'participants_file' => 'required|file|mimes:csv,xlsx',
        ]);
        $timezone='Asia/Kolkata';
        DB::table('quizzes')->insert([ 
            'quiz_name' => $request->quiz_name,
            'test_length' => $request->quiz_length,
            'start_time' => Carbon::parse($request->start_time, $timezone)->setTimezone('UTC'),
            'end_time' => Carbon::parse($request->end_time, $timezone)->setTimezone('UTC'),
        ]);

        // Create dynamic table names
        $questionsTable = "{$request->quiz_name}_questions";
        $participantsTable = "{$request->quiz_name}_participants";

        // Create Questions table
        Schema::create($questionsTable, function (Blueprint $table) {
            $table->increments('id');
            $table->text('question');
            $table->text('op1');
            $table->text('op2');
            $table->text('op3');
            $table->text('op4');
            $table->text('ans');
            $table->timestamps();
        });

        // Create Participants table
        Schema::create($participantsTable, function (Blueprint $table) {
            $table->increments('id');
            $table->string('application_id')->unique();
            $table->date('dob')->nullable(); // Ensure to allow null for dob
            $table->boolean('attempted')->nullable()->default(false);
            $table->integer('score')->nullable();
            $table->integer('wrong')->nullable();
            $table->integer('unanswered')->nullable();
            $table->dateTime('endtime')->nullable();
            $table->timestamps();
        });

        // Parse and insert questions
        try {
            // Parse and insert questions
            Excel::import(new QuestionsImport($questionsTable), $request->file('questions_file'));
    
            // Parse and insert participants
            Excel::import(new ParticipantsImport($participantsTable), $request->file('participants_file'));
    
            return redirect()->route('CreateQuiz')->with('success', 'Quiz created successfully!');
    
        } catch (\Exception $e) {
            // Handle any errors during import
            return redirect()->route('CreateQuiz')->withErrors(['error' => $e->getMessage()]);
        }
        return redirect()->route('CreateQuiz')->with('success', 'Quiz created successfully!');
    }
}
