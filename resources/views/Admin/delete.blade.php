<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Quiz</title>
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
            height: 100vh;
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
        /* Modal Styles */
        .modal {
            display: none; /* Hidden by default */
            position: fixed;
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            background-color: rgba(0, 0, 0, 0.4); /* Semi-transparent background */
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 40%;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .modal button {
            margin-top: 10px;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
        }

        .modal button[type="button"] {
            background-color: #f44336;
        }

        .modal button:hover {
            opacity: 0.9;
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
            <li><a href="/CreateQuiz">Create Quiz</a></li>
            <li><a href="/EditQuizPage">Edit Quiz</a></li>
            <li><a href="/DeleteQuizPage" id="active_link">Delete Quiz</a></li>
            <li><a href="/ResultsPage">Results</a></li>
            <li><a href="/AdminLogout" onclick="event.preventDefault(); document.getElementById('logout-form').submit();">Logout</a></li>
        </ul>
        <form id="logout-form" action="/AdminLogout" method="POST" style="display: none;">
            @csrf
        </form>
    </div>

    <!-- Modal -->
    <div id="confirmationModal" class="modal">
        <div class="modal-content">
            <h3>Confirm Delete</h3>
            <p>Are you sure you want to delete the quiz: <span id="quizNameDisplay"></span>?</p>
            <form id="deleteForm" action="/DeleteQuiz" method="POST">
                @csrf
                <input type="hidden" name="quiz_name" id="quizNameInput">
                <button type="submit">Yes, Delete Quiz</button>
                <button type="button" onclick="closeModal()">Cancel</button>
            </form>
        </div>
    </div>

    <!-- Main content area -->
    <div class="content">
        <h1>Delete Quiz</h1>
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

        <!-- Quiz Deletion Form -->
        <form id="deleteQuizForm" method="POST">
            @csrf
            <!-- Quiz Name -->
            <div class="form-group">
                <label for="category">Choose Quiz to Delete:</label>
                <select class="inputs" id="category" name="quiz_name" required>
                    <option value="" selected disabled hidden>Select Quiz</option>
                    @foreach($quiz as $q)
                        <option value="{{$q->quiz_name}}">{{$q->quiz_name}}</option>
                    @endforeach
                </select>
            </div>

            <!-- Delete Button -->
            <div class="form-group">
                <button type="button" id="deleteQuizButton">Delete Quiz</button>
            </div>
        </form>
    </div>

    <script>
        // Function to open the modal
        function openModal(quizName) {
            document.getElementById('quizNameDisplay').innerText = quizName;
            document.getElementById('quizNameInput').value = quizName;
            document.getElementById('confirmationModal').style.display = 'block';
        }

        // Function to close the modal
        function closeModal() {
            document.getElementById('confirmationModal').style.display = 'none';
        }

        // Add event listener to the delete button
        document.getElementById('deleteQuizButton').addEventListener('click', function() {
            const selectedQuizName = document.getElementById('category').value;
            if (selectedQuizName) {
                openModal(selectedQuizName);
            } else {
                alert('Please select a quiz to delete.');
            }
        });
    </script>
</body>
</html>
