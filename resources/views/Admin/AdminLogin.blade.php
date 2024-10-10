<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <style>
        /* General reset and styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fc; /* Match the background color */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* Login container styling */
        .login-container {
            background-color: #ffffff;
            padding: 20px; /* Match padding */
            border-radius: 8px; /* Match border-radius */
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* Match box-shadow */
            width: 300px; /* Match width */
        }

        h2 {
            text-align: center;
            color: #007BFF; /* Match the blue color */
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px; /* Match margin-bottom */
        }

        .form-group label {
            display: block;
            font-size: 14px; /* Match font-size */
            color: #333;
            margin-bottom: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px; /* Match border-radius */
            font-size: 14px; /* Match font-size */
            outline: none;
        }

        .form-group input:focus {
            border-color: #007BFF; /* Match the blue border color */
        }

        /* Button styling */
        .login-btn {
            background-color: #007BFF; /* Match blue button color */
            color: white;
            padding: 10px;
            font-size: 16px; /* Match font-size */
            border: none;
            border-radius: 4px; /* Match border-radius */
            cursor: pointer;
            width: 100%;
        }

        .login-btn:hover {
            background-color: #0056b3; /* Match hover color */
        }

        /* Error messages styling */
        .alert {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 4px;
            margin-top: 10px;
        }

        /* Link styling */
        .forgot-password {
            text-align: center;
            margin-top: 10px;
        }

        .forgot-password a {
            color: #007BFF; /* Match link color */
            text-decoration: none;
            font-size: 14px;
        }

        .forgot-password a:hover {
            text-decoration: underline;
        }
    </style>
    <!-- <script>
        window.addEventListener('pageshow', function(event) {

            if (event.persisted) {
                window.location.reload();
            }
        });
        let user = "{{Session::has('admin')}}";
        if(!user)
            window.location.href = 'AdminLoginPage';
    </script> -->
</head>
<body>
    <div class="login-container">
        <h2>Admin Login</h2>
        <form action="/AdminLogin" method="POST">
            @csrf

            <!-- Email Input -->
            <div class="form-group">
                <label for="email">Username (Email)</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" value="{{ old('email') }}" required>
                @if ($errors->has('email'))
                    <div class="alert">{{ $errors->first('email') }}</div>
                @endif
            </div>

            <!-- Password Input -->
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
                @if ($errors->has('password'))
                    <div class="alert">{{ $errors->first('password') }}</div>
                @endif
            </div>

            <!-- Submit Button -->
            <button type="submit" class="login-btn">Login</button>
            <div class="form-group">
                <a href="{{ route('reset_pass_admin') }}" class="font loadspin" style="font-size:14px; text-decoration:none;">Forgot Password?</a>
            </div>

            @if (session('error'))
                <div class="alert">
                    {{ session('error') }}
                </div>
            @endif
        </form>
    </div>
</body>
</html>
