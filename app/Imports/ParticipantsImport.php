<?php

namespace App\Imports;

use App\Models\Participant; 
use Maatwebsite\Excel\Concerns\ToModel;

class ParticipantsImport implements ToModel
{
    protected $table;

    public function __construct($table)
    {
        $this->table = $table;
    }

    public function model(array $row)
    {
        // Trim the DOB string from the row
        $dobString = trim($row[1]); 

        \Log::info('Raw DOB String: ', ['dob_string' => $dobString]);

        // Check if the string is numeric (indicating it's an Excel serial date)
        if (is_numeric($dobString)) {
            // Convert the Excel serial date to a PHP DateTime object
            $baseDate = new \DateTime('1899-12-30');
            $dob = $baseDate->modify("+{$dobString} days");
        } else {
            // Convert the date format from DD-MM-YYYY to YYYY-MM-DD
            $dob = \DateTime::createFromFormat('d-m-Y', $dobString);
        }

        // Format the date
        $dobFormatted = $dob ? $dob->format('Y-m-d') : null; // Handle invalid date format

        // Create a new instance of Participant and set the table dynamically
        $participant = new Participant();
        $participant->setTable($this->table); // Dynamically set the table name

        return $participant->fill([
            'application_id' => trim($row[0]),
            'dob' => $dobFormatted, // Use the formatted date
            'attempted' => null,
            'score' => null,
            'endtime' => null, // Add this if you want to set a default value
        ]);
    }

}
