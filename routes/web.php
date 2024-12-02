<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\QuizEntry;
use App\Http\Controllers\Admin\AdminQuiz;
use App\Http\Controllers\Admin\ForgotPasswordAdminController;
use App\Http\Controllers\Admin\QuizController;
use App\Http\Controllers\Candidate\Validate;

Route::get('/', function () {
    $stmt="select * from quizzes;"; 
    $quiz = DB::select($stmt);
    return view('Home', ['quiz' => $quiz]);
});


// AdminQuiz Controller
Route::get('/CreateQuiz', [AdminQuiz::class,'AdminDashboard'])->name('CreateQuiz');
Route::get('/DeleteQuizPage', [AdminQuiz::class,'DeleteQuizPage'])->name('DeleteQuizPage');
Route::post('/DeleteQuiz', [AdminQuiz::class, 'deleteQuiz'])->name('deleteQuiz');
Route::get('/AdminLoginPage', [AdminQuiz::class, 'AdminLoginPage'])->name('AdminLoginPage');
Route::post('/AdminLogin', [AdminQuiz::class, 'AdminLogin'])->name('AdminLogin');
Route::post('/AdminLogout', [AdminQuiz::class, 'AdminLogout'])->name('AdminLogout');
Route::get('/ResultsPage', [AdminQuiz::class, 'ResultsPage'])->name('ResultsPage');
Route::post('/GetResult', [AdminQuiz::class, 'GetResults'])->name('GetResult');
Route::post('/resetSelectedTests', [AdminQuiz::class, 'resetSelectedTests'])->name('resetSelectedTests');
Route::get('/EditQuizPage', [AdminQuiz::class, 'EditQuizPage'])->name('EditQuizPage');
Route::post('/EditQuiz', [AdminQuiz::class, 'EditQuiz'])->name('EditQuiz');
Route::post('/ResetQuiz/{id}', [AdminQuiz::class, 'ResetQuiz'])->name('ResetQuiz');
Route::post('/ResetQuizBulk/{id}', [AdminQuiz::class, 'ResetQuizBulk'])->name('ResetQuizBulk');

// Quiz Controller
Route::post('/CreateNewQuiz', [QuizController::class,'CreateNewQuiz'])->name('CreateNewQuiz');

// Validate
Route::post('/ValidateUser', [Validate::class,'ValidateUser'])->name('ValidateUser');
Route::post('/SubmitQuiz', [Validate::class,'submitQuiz'])->name('SubmitQuiz');
Route::get('/thanksPage', [Validate::class, 'showThanksPage'])->name('thanksPage');


//Reset Password for Admin
Route::get('reset_pass_admin', [ForgotPasswordAdminController::class, 'showForgetPasswordForm'])->name('reset_pass_admin');
Route::post('admin-forget-password', [ForgotPasswordAdminController::class, 'submitForgetPasswordForm'])->name('admin-forget.password.post'); 
Route::get('admin-reset.password/{token}', [ForgotPasswordAdminController::class, 'showResetPasswordForm'])->name('admin-reset.password.get');
Route::post('admin-reset.password', [ForgotPasswordAdminController::class, 'submitResetPasswordForm'])->name('admin-reset.password.post');