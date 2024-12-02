<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz</title>
    <script src="/assets/js/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="/assets/css/QuizPage.css">
</head>
<body>
    @php
        $currentTime = \Carbon\Carbon::now('Asia/Kolkata'); // Get current time
        $startTime = \Carbon\Carbon::parse($quiz->start_time)->timezone('Asia/Kolkata');
        $endTestTime = \Carbon\Carbon::parse($quiz->end_time)->timezone('Asia/Kolkata');
        if(Session::has('questions')) {
            $questions = Session::get('questions');
        }
        $candidate = Session::get('candidate');
    @endphp

    @if($currentTime < $startTime)
        <div class="beforeTest">
            The test will start in <br>
            <div id="countdown"></div>
        </div>
        <script>
            var startTime = new Date("{{ $startTime }}").getTime();
            var serverTime = new Date("{{ $currentTime }}").getTime();
            var currentTime = serverTime; 
            var countdownInterval = setInterval(function() {
                currentTime += 1000; 

                var timeDifference = startTime - currentTime;
                var days = Math.floor(timeDifference / (1000 * 60 * 60 * 24));
                var hours = Math.floor((timeDifference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                var minutes = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
                var seconds = Math.floor((timeDifference % (1000 * 60)) / 1000);
                
                document.getElementById("countdown").innerHTML = days + "d " + hours + "h " 
                    + minutes + "m " + seconds + "s ";
                
                if (timeDifference < 0) {
                    clearInterval(countdownInterval);
                    document.getElementById("countdown").innerHTML = "The test has started!";
                    window.location.reload(); // Reload only when the countdown ends
                }
            }, 1000);
        </script>
    @elseif(($endTime == NULL) && ($currentTime > $endTestTime))
        <div class="afterTest">
            The test has expired
        </div>
    @elseif(($participant) && ($participant->attempted == 1))
        <div class="afterTest">
            Responses are getting recorded, please wait... 
        </div>
    @else
        <div class="nav-bar">
            <div class="app-id">Application ID: {{ $candidate->application_id }}</div>
            <div class="timer" id="timer">00:00</div>
            <button type="button" class="submit-btn" id="submitQuizBtn">Submit Test</button>
        </div>

    <form id="quizForm" action="/SubmitQuiz" method="POST">
            @csrf
            <input type="text" value="{{$applicationId}}" name="applicationId" hidden>
            <input type="text" value="{{$QuestionTable}}" name="QuestionTable" hidden>
            <input type="text" value="{{$ParticipantsTable}}" name="ParticipantsTable" hidden>
            <div class="main-content-timer">
                @foreach ($questions as $question)
                    <div class="question" id="question-{{ $question->id }}" style="display: none;">
                        <h4>{{ $question->question }}</h4>
                        <div class="options">
                            <label>
                                <input type="radio" name="question_{{ $question->id }}" value="1">
                                {{ $question->op1 }}
                            </label>
                        </div>
                        <div class="options">
                            <label>
                                <input type="radio" name="question_{{ $question->id }}" value="2">
                                {{ $question->op2 }}
                            </label>
                        </div>
                        <div class="options">
                            <label>
                                <input type="radio" name="question_{{ $question->id }}" value="3">
                                {{ $question->op3 }}
                            </label>
                        </div>
                        <div class="options">
                            <label>
                                <input type="radio" name="question_{{ $question->id }}" value="4">
                                {{ $question->op4 }}
                            </label>
                        </div>
                    </div>
                @endforeach
            </div>
        </form>

        <div id="submitModal" class="modal" style="display: none;">
            <div class="modal-content">
                <span class="close">&times;</span>
                <p>Are you sure you want to submit the quiz?</p>
                <button id="confirmSubmit">Yes</button>
                <button id="cancelSubmit">No</button>
            </div>
        </div>
    @endif
    <script>
        $(document).ready(function () {
            let currentQuestionIndex = parseInt(localStorage.getItem('currentQuestionIndex')) || 0;
            const questions = @json($questions);
            const totalQuestions = questions.length;
            let timerInterval;
            let formSubmitted = false;

            function showQuestion(index) {
                if (index >= totalQuestions) {
                    if (!formSubmitted) {
                        formSubmitted = true;
                        $('#quizForm').submit();
                    }
                    return;
                }

                $('.question').hide();
                $(`#question-${questions[index].id}`).show();
                localStorage.setItem('currentQuestionIndex', index);
                startTimer(questions[index].timer, index);
            }

            function startTimer(duration, questionIndex) {
                clearInterval(timerInterval);

                let timer = parseInt(localStorage.getItem(`timer-${questionIndex}`)) || duration;
                const timerElement = $('#timer');
                timerElement.text(formatTime(timer));

                timerInterval = setInterval(() => {
                    timer -= 1;
                    timerElement.text(formatTime(timer));
                    localStorage.setItem(`timer-${questionIndex}`, timer);

                    if (timer <= 0) {
                        clearInterval(timerInterval);
                        localStorage.removeItem(`timer-${questionIndex}`);
                        currentQuestionIndex += 1;
                        showQuestion(currentQuestionIndex);
                    }
                }, 1000);
            }

            function formatTime(seconds) {
                const minutes = Math.floor(seconds / 60).toString().padStart(2, '0');
                const secs = (seconds % 60).toString().padStart(2, '0');
                return `${minutes}:${secs}`;
            }

            $('.options input[type="radio"]').on('change', function () {
                const questionId = $(this).attr('name');
                const selectedValue = $(this).val();

                // Store the selected value in localStorage
                localStorage.setItem(questionId, selectedValue);

                // Disable all other options except the selected one
                $(`input[name="${questionId}"]`).each(function () {
                    if ($(this).val() !== selectedValue) {
                        $(this).prop('disabled', true); // Disable the non-selected options
                    } else {
                        $(this).prop('disabled', false); // Ensure the selected option remains enabled
                    }
                });
            });

            function restoreAnswers() {
                $('.options input[type="radio"]').each(function () {
                    const questionId = $(this).attr('name');
                    const savedValue = localStorage.getItem(questionId);
                    if (savedValue) {
                        if ($(this).val() === savedValue) {
                            $(this).prop('checked', true);
                        }
                        // Disable non-selected options
                        $(`input[name="${questionId}"]`).each(function () {
                            if ($(this).val() !== savedValue) {
                                $(this).prop('disabled', true); // Disable the non-selected options
                            }
                        });
                    }
                });
            }

            $('#submitQuizBtn').click(function () {
                if (!formSubmitted) {
                    $('#submitModal').show();
                }
            });

            $('#confirmSubmit').click(function () {
                formSubmitted = true;

                // Do not disable the options before submitting the form
                // Ensure all selected values are stored in localStorage
                $('.options input[type="radio"]:checked').each(function () {
                    const questionId = $(this).attr('name');
                    const selectedValue = $(this).val();
                    localStorage.setItem(questionId, selectedValue);
                });

                // Submit the form without disabling inputs
                $('#quizForm').submit();
            });

            $('.close, #cancelSubmit').click(function () {
                $('#submitModal').hide();
            });

            $(window).click(function (event) {
                if ($(event.target).is('#submitModal')) {
                    $('#submitModal').hide();
                }
            });

            restoreAnswers();
            showQuestion(currentQuestionIndex);
        });

    </script>
</body>
</html>
