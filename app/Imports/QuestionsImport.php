<?php

namespace App\Imports;

use App\Models\Question; 
use Maatwebsite\Excel\Concerns\ToModel;

class QuestionsImport implements ToModel
{
    protected $table;
    protected $quiz_type;

    public function __construct($table, $type)
    {
        $this->table = $table;
        $this->quiz_type = $type;
    }

    public function model(array $row)
    {
        // Check if the row is empty or the required fields are null
        if (empty($row[0]) || empty($row[1]) || empty($row[2]) || empty($row[3]) || empty($row[4]) || empty($row[5])) {
            return null; // Skip this row
        }

        // Create a new instance of Question and set the table dynamically
        $question = new Question();
        $question->initialize($this->quiz_type);
        $question->setTable($this->table); // Dynamically set the table name

        // Table Format
        $data = [
            'question' => $row[0],
            'op1' => $row[1],
            'op2' => $row[2],
            'op3' => $row[3],
            'op4' => $row[4],
            'ans' => $row[5],
        ];
        
        // Check to find if timer field is required 
        if($this->quiz_type == 3 || $this->quiz_type == 4)
        {
            if(empty($row[6]))
                return null;
            $data['timer'] = (int)$row[6];
        }

        // Return the question filled with valid data
        return $question->fill($data);
    }
}
