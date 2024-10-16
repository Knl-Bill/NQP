<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        /* General reset and styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff; /* Light blue background */
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h2 {
            color: #1e90ff; /* DodgerBlue heading */
            text-align: center;
            margin: 20px 0;
        }

        /* Table styling */
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px 20px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #1e90ff; /* DodgerBlue header */
            color: white;
        }

        td {
            color: #333;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #e0f7ff; /* Light hover effect */
        }

        /* Button styling */
        button {
            background-color: #1e90ff; /* DodgerBlue button */
            color: white;
            border: none;
            padding: 8px 16px;
            cursor: pointer;
            font-size: 16px;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #1c86ee; /* Slightly darker blue on hover */
        }

        /* Modal styling */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 80%; /* Could be more or less, depending on screen size */
        }

        /* Responsive design */
        @media (max-width: 768px) {
            table {
                width: 100%;
            }

            th, td {
                padding: 10px 15px;
            }

            h2 {
                font-size: 24px;
            }

            button {
                font-size: 14px;
                padding: 6px 12px;
            }
        }
    </style>
</head>
<body>
    <!-- Render Participants List if Quiz is Selected -->
    <h2>Participants List</h2>
    <table>
        <thead>
            <tr>
                <th>Participant</th>
                <th>Reset Test</th>
            </tr>
        </thead>
        <tbody>
            @foreach($participants as $participant)
                <tr>
                    <td>{{ $participant->application_id }}</td>
                    <td>
                        <!-- Reset Test Button -->
                        <button onclick="openModal('{{ $participant->id }}', '{{ $selectedQuiz }}')">Reset Test</button>
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>

    <!-- Modal -->
    <div id="confirmationModal" class="modal">
        <div class="modal-content">
            <h3>Confirm Reset</h3>
            <p>Are you sure you want to reset the test for <span id="participantIdDisplay"></span>?</p>
            <form id="resetForm" action="" method="POST">
                @csrf
                <input type="hidden" name="quiz_name" id="quizName" required>
                <input type="hidden" name="participant_id" id="participantId" required>
                <button type="button" onclick="submitReset()">Yes, Reset Test</button>
                <button type="button" onclick="closeModal()">Cancel</button>
            </form>
        </div>
    </div>

    <script>
        function openModal(participantId, quizName) {
            // Set participant ID and display it
            document.getElementById('participantId').value = participantId;
            document.getElementById('participantIdDisplay').innerText = participantId; // Assuming participant ID is used as a display name
            document.getElementById('quizName').value = quizName;

            // Show the modal
            document.getElementById('confirmationModal').style.display = 'block';
        }

        function closeModal() {
            // Hide the modal
            document.getElementById('confirmationModal').style.display = 'none';
        }

        function submitReset() {
            // Get the form and submit it
            document.getElementById('resetForm').action = '/ResetQuiz/' + document.getElementById('participantId').value;
            document.getElementById('resetForm').submit();
        }

        // Close the modal if user clicks outside of it
        window.onclick = function(event) {
            var modal = document.getElementById('confirmationModal');
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>
</body>
</html>
