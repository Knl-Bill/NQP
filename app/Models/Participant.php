<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Participant extends Model
{
    use HasFactory;

    protected $table = 'participants'; // Change to your actual table name if needed

    // Specify the fillable fields to protect against mass assignment vulnerabilities
    protected $fillable = [
        'application_id',
        'dob',
        'attempted',
        'score',
        'endtime',
    ];
}
