<?php

namespace App\Http\Controllers\Admin;
use App\Http\Requests;
use App\Models\password_reset_admin;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Str;
use DB;
use Carbon\Carbon;
use Mail;
use Hash;
class ForgotPasswordAdminController extends Controller
{
    /**
       * Write code on Method
       *
       * @return response()
       */
      public function showForgetPasswordForm()
      {
         return view('Admin.forgetPassword');
      }
      /**
       * Write code on Method
       *
       * @return response()
       */
      public function submitForgetPasswordForm(Request $request)
      {
          $request->validate([
              'email' => 'required|email|exists:users',
          ]);
  
          $token = Str::random(64);
          if(DB::table('password_reset_admins')->where('email',$request->email)->exists())
          {
            DB::table('password_reset_admins')
            ->where('email', $email)
            ->update([
                'token' => $token,
                'created_at' => Carbon::now(),
            ]);
          }
          else{
              DB::table('password_reset_admins')->insert([
                  'email' => $request->email, 
                  'token' => $token, 
                  'created_at' => Carbon::now()
                ]);
          }
  
          Mail::send('email.AdminforgetPassword', ['token' => $token], function($message) use($request){
              $message->to($request->email);
              $message->subject('Reset Password');
          });
  
          return back()->with('message', 'We have e-mailed your password reset link!');
      }
      /**
       * Write code on Method
       *
       * @return response()
       */
      public function showResetPasswordForm($token)
      { 
         return view('Admin.forgetPasswordLink', ['token' => $token]);
      }
  
      /**
       * Write code on Method
       *
       * @return response()
       */
      public function submitResetPasswordForm(Request $request)
      {
          $request->validate([
              'email' => 'required|email|exists:users',
              'password' => 'required|string|min:8|regex:/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/',
              'password_confirmation' => 'required|same:password',
          ]);
  
          $updatePassword = DB::table('password_reset_admins')
                              ->where([
                                'email' => $request->email, 
                                'token' => $request->token
                              ])
                              ->first();
  
          if(!$updatePassword){
              return back()->with('error', 'Invalid token!');
          }
  
          $user = DB::table('users')->where('email', $request->email)
                      ->update(['password' => Hash::make($request->password)]);
 
          DB::table('password_reset_admins')->where(['email'=> $request->email])->delete();
  
          return redirect()->route('AdminLoginPage')->with('success',"Password Changed Successfully");
      }
}
