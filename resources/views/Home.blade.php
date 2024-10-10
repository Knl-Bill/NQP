<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NITPY Quiz App</title>
    <style>
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body{
            font-family: Arial, sans-serif;
            background-color: #f4f7fc;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container{
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 300px;
        }

        h2{
            text-align: center;
            color: #007BFF;
            margin-bottom: 20px;
        }

        .form-group{
            margin-bottom: 15px;
        }

        label{
            display: block;
            font-size: 14px;
            color: #333;
            margin-bottom: 5px;
        }

        select, input{
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            outline: none;
        }

        select:focus, input:focus{
            border-color: #007BFF;
        }

        input[type="date"]{
            color: #555;
        }

        .submit-btn{
            background-color: #007BFF;
            color: #ffffff;
            border: none;
            padding: 10px;
            border-radius: 4px;
            width: 100%;
            cursor: pointer;
            font-size: 16px;
        }

        .submit-btn:hover{
            background-color: #0056b3;
        }
        .alert {
            background-color: #f8d7da;
            color: #721c24;
            padding: 2px;
            border-radius: 4px;
            margin-top: 10px;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Quiz App</h2>
        @if($errors->any())
            <div>
                @foreach($errors->all() as $error)
                    <div class="alert">{{ $error }}</div>
                @endforeach
            </div>
        @endif
        <form action="/ValidateUser" method="post">
            @csrf
            <!-- Dropdown -->
            <div class="form-group">
                <label for="category">Choose Quiz:</label>
                <select class="inputs" id="category" name="category" required>
                    <option value="" selected disabled hidden>Select Quiz</option>
                    @foreach($quiz as $q)
                    <option value= "{{$q->quiz_name}}" >{{$q->quiz_name}}</option>
                    @endforeach
                </select>
            </div>

            <!-- Username -->
            <div class="form-group">
                <label for="username">Application ID:</label>
                <input type="text" id="username" name="username" placeholder="Enter your username" required>
            </div>

            <!-- Birthdate -->
            <div class="form-group">
                <label for="birthdate">Date of Birth:</label>
                <input type="date" id="birthdate" name="birthdate" required>
            </div>

            <!-- Submit Button -->
            <div class="form-group">
                <button type="submit" class="submit-btn">Submit</button>
            </div>
        </form>
    </div>
</body>
</html>
