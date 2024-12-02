<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Question extends Model
{
    use HasFactory;

    protected $table; // Change to your actual table name if needed

    // Specify the fillable fields to protect against mass assignment vulnerabilities
    protected $fillable = [// Assuming you want to link questions to a specific quiz
        'question',
        'op1',
        'op2',
        'op3',
        'op4',
        'ans',
    ];

    public function initialize($quiz_type)
    {
        if(in_array($quiz_type, [3,4]))
            $this->fillable[] = 'timer';
    }
}
