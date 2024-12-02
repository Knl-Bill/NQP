<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Quiz</title>
    <style>
        /* General reset and styles */
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
        }

        /* Sidebar styling */
        .sidebar {
            width: 250px;
            background-color: #2c3e50;
            color: white;
            height: 105vh;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }

        .sidebar h2 {
            text-align: center;
            font-size: 24px;
            margin-bottom: 30px;
        }

        .sidebar ul {
            list-style-type: none;
            padding: 0;
        }

        .sidebar ul li {
            margin: 20px 0;
        }

        .sidebar ul li a {
            text-decoration: none;
            color: white;
            font-size: 18px;
            display: block;
            padding: 10px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .sidebar ul li a:hover {
            background-color: #34495e;
        }

        #active_link {
            background-color: #34495e;
        }

        /* Main content area */
        .content {
            flex: 1;
            background-color: #ecf0f1;
            padding: 40px;
        }

        .content h1 {
            font-size: 32px;
            color: #333;
            margin-bottom: 20px;
        }

        .content form {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .form-group input[type="file"] {
            padding: 5px;
        }

        .form-group button {
            background-color: #2c3e50;
            color: white;
            padding: 10px 15px;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-group button:hover {
            background-color: #34495e;
        }
        .success {
            color:green;
        }
    </style>
    <script>
        window.addEventListener('pageshow', function(event) {
            if(event.persisted) {
                window.location.reload();
            }
        });
        let user = "{{ Session::has('admin') }}";
        if (!user) {
            window.location.href = '/';
        }
    </script>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h2>{{$user->name}}</h2>
        <ul>
            <li><a href="/CreateQuiz" id="active_link">Create Quiz</a></li>
            <li><a href="/EditQuizPage">Edit Quiz</a></li>
            <li><a href="/ResultsPage">Results</a></li>
            <li><a href="/AdminLogout" onclick="event.preventDefault(); document.getElementById('logout-form').submit();">Logout</a></li>
        </ul>
        <form id="logout-form" action="/AdminLogout" method="POST" style="display: none;">
            @csrf
        </form>
    </div>

    <!-- Main content area -->
    <div class="content">
        <h1>Create New Quiz</h1>
        @if(session('success'))
            <div class="success">
                {{ session('success') }}
            </div>
        @endif

        @if($errors->any())
            <div class="error">
                <ul>
                    @foreach($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif

        <form action="/CreateNewQuiz" method="POST" enctype="multipart/form-data">
            @csrf
            <!-- Quiz Name -->
            <div class="form-group">
                <label for="quiz_name">Quiz Name</label>
                <input type="text" id="quiz_name" name="quiz_name" placeholder="Enter Quiz Name" required>
            </div>
            <?php
                $QuizType = Session::get('QuizType');
            ?>
            <!-- Quiz Type -->
            <div class="form-group">
                <label for="quiz_type">Quiz Type</label>
                <select id="quiz_type" name="quiz_type" required>
                    <option value="" disabled selected>Select Quiz Type</option>
                    @foreach($QuizType as $type)
                        <option value="{{ $type->id }}">{{ $type->type }}</option>
                    @endforeach
                </select>
            </div>

            <!-- Quiz Length -->
            <div class="form-group">
                <label for="quiz_length">Quiz Length (in minutes)</label>
                <input type="number" id="quiz_length" name="quiz_length" placeholder="Enter Quiz Length" required>
            </div>

            <!-- Start Time -->
            <div class="form-group">
                <label for="start_time">Start Time</label>
                <input type="datetime-local" id="start_time" name="start_time" required>
            </div>

            <!-- End Time -->
            <div class="form-group">
                <label for="end_time">End Time</label>
                <input type="datetime-local" id="end_time" name="end_time" required>
            </div>

            <!-- Questions File Upload -->
            <div class="form-group">
                <label for="questions_file">Questions File (.csv or .xlsx)</label>
                <input type="file" id="questions_file" name="questions_file" accept=".csv,.xlsx" required>
            </div>

            <!-- Participants File Upload -->
            <div class="form-group">
                <label for="participants_file">Participants File (.csv or .xlsx)</label>
                <input type="file" id="participants_file" name="participants_file" accept=".csv,.xlsx" required>
            </div>

            <!-- Submit Button -->
            <div class="form-group">
                <button type="submit">Create Quiz</button>
            </div>
        </form>
    </div>
</body>
</html>
