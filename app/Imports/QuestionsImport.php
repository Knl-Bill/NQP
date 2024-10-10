<?php

namespace App\Imports;

use App\Models\Question; 
use Maatwebsite\Excel\Concerns\ToModel;

class QuestionsImport implements ToModel
{
    protected $table;

    public function __construct($table)
    {
        $this->table = $table;
    }

    public function model(array $row)
    {
        // Check if the row is empty or the required fields are null
        if (empty($row[0]) || empty($row[1]) || empty($row[2]) || empty($row[3]) || empty($row[4]) || empty($row[5])) {
            return null; // Skip this row
        }

        // Create a new instance of Question and set the table dynamically
        $question = new Question();
        $question->setTable($this->table); // Dynamically set the table name

        // Return the question filled with valid data
        return $question->fill([
            'question' => $row[0],
            'op1' => $row[1],
            'op2' => $row[2],
            'op3' => $row[3],
            'op4' => $row[4],
            'ans' => $row[5],
        ]);
    }
}
