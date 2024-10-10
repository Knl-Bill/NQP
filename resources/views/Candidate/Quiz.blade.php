<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="/assets/css/QuizPage.css">
    <script>
        window.addEventListener('pageshow', function(event) {
            if (event.persisted) {
                window.location.reload();
            }
        });
        let user = "{{ Session::has('candidate') }}";
        if (!user) {
            window.location.href = '/';
        }
    </script>
</head>
<body>
    @php
        $currentTime = \Carbon\Carbon::now()->timezone('Asia/Kolkata'); // Get current time
        $startTime = \Carbon\Carbon::parse($quiz->start_time)->timezone('Asia/Kolkata');
        $endTestTime = \Carbon\Carbon::parse($quiz->end_time)->timezone('Asia/Kolkata');
    @endphp

    @if($currentTime < $startTime)
        <div class="beforeTest">
            The test will start in <br>
            <div id="countdown"></div>
        </div>
        <script>
            var startTime = new Date("{{ $startTime }}").getTime();
            var countdownInterval = setInterval(function() {
                var currentTime = new Date().getTime();
                var timeDifference = startTime - currentTime;
                var days = Math.floor(timeDifference / (1000 * 60 * 60 * 24));
                var hours = Math.floor((timeDifference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                var minutes = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
                var seconds = Math.floor((timeDifference % (1000 * 60)) / 1000);
                document.getElementById("countdown").innerHTML = days + "d " + hours + "h " 
                    + minutes + "m " + seconds + "s ";
                if (timeDifference < 0) {
                    clearInterval(countdownInterval);
                    window.location.reload();
                    document.getElementById("countdown").innerHTML = "The test has started!";
                }
            }, 1000);
        </script>
    @elseif(($endTime == NULL) && ($currentTime > $endTestTime))
        <div class="afterTest">
            The test has expired
        </div>
    @else
        <div class="nav-bar">
            <?php
                $candidate = "Guest";
                if(Session::has('candidate')) {
                    $candidate = Session::get('candidate');
                }
            ?>
            <div class="app-id">Application ID: {{ $candidate->application_id }}</div>
            <div class="timer" id="timer"></div>
        </div>
        <form action="/SubmitQuiz" method="POST" id="quizForm"> 
            @csrf 
            <input type="text" value="{{$applicationId}}" name="applicationId" hidden>
            <input type="text" value="{{$QuestionTable}}" name="QuestionTable" hidden>
            <input type="text" value="{{$ParticipantsTable}}" name="ParticipantsTable" hidden>
            <div class="main-content">
                <div class="left-panel">
                    @foreach ($questions as $question)
                        <a href="#" class="question-link unanswered" data-question-id="{{ $question->id }}">{{ $loop->iteration }}</a>
                    @endforeach

                    <!-- Submit button in the left panel -->
                    <div class="submit-btn-container">
                        <button type="button" class="submit-btn" id="submitQuizBtn">Submit Test</button>
                    </div>
                </div>

                <div class="right-panel" id="question-panel">
                    @foreach ($questions as $question)
                        <div class="question" id="question-{{ $question->id }}" style="display: none;">
                            <h4>{{ $question->question }}</h4>
                            <div>
                                <input type="radio" name="question_{{ $question->id }}" value="1" class="option" {{ old("question_{$question->id}") == 1 ? 'checked' : '' }}>
                                {{ $question->op1 }}
                            </div>
                            <div>
                                <input type="radio" name="question_{{ $question->id }}" value="2" class="option" {{ old("question_{$question->id}") == 2 ? 'checked' : '' }}>
                                {{ $question->op2 }}
                            </div>
                            <div>
                                <input type="radio" name="question_{{ $question->id }}" value="3" class="option" {{ old("question_{$question->id}") == 3 ? 'checked' : '' }}>
                                {{ $question->op3 }}
                            </div>
                            <div>
                                <input type="radio" name="question_{{ $question->id }}" value="4" class="option" {{ old("question_{$question->id}") == 4 ? 'checked' : '' }}>
                                {{ $question->op4 }}
                            </div>
                        </div>
                    @endforeach
                </div>
            </div>
        </form>
    @endif
    <div id="submitModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h3>Confirm Submission</h3>
            <p>Are you sure you want to submit the test?</p>
            <div class="modal-footer">
                <button id="confirmSubmit">Yes, Submit</button>
                <button id="cancelSubmit">Cancel</button>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function() {
            $('.question').hide();
            $('#question-1').show(); 
            $('.question-link').click(function(e) {
                e.preventDefault();
                var questionId = $(this).data('question-id');
                $('.question').hide();
                $('#question-' + questionId).show();
                $('.question-link').removeClass('selected');
                $(this).addClass('selected');
                updateQuestionLinkStates();
            });

            // Load saved answers from localStorage
            $('.option').each(function() {
                var questionId = $(this).closest('.question').attr('id').split('-')[1];
                var savedAnswer = localStorage.getItem('question_' + questionId);
                if (savedAnswer) {
                    $(this).prop('checked', savedAnswer == $(this).val());
                }
            });

            $('.option').change(function() {
                var questionId = $(this).closest('.question').attr('id').split('-')[1];
                localStorage.setItem('question_' + questionId, $(this).val());
                $(this).closest('.question-link').removeClass('unanswered').addClass('answered');
                updateQuestionLinkStates();
            });

            $('#submitQuizBtn').click(function() {
                $('#submitModal').show();
            });

            // Confirm submission
            $('#confirmSubmit').click(function() {
                localStorage.clear(); // Clear saved answers before submitting
                $('#quizForm').submit();
            });

            // Close modal
            $('.close, #cancelSubmit').click(function() {
                $('#submitModal').hide();
            });

            $(window).click(function(event) {
                if ($(event.target).is('#submitModal')) {
                    $('#submitModal').hide();
                }
            });


            function updateQuestionLinkStates() {
                $('.question').each(function() {
                    var questionId = $(this).attr('id').split('-')[1];
                    var isAnswered = $(this).find('.option:checked').length > 0;
                    var link = $('.question-link[data-question-id="' + questionId + '"]');

                    if (isAnswered) {
                        link.removeClass('unanswered').addClass('answered');
                    } else {
                        link.removeClass('answered').addClass('unanswered');
                    }
                });
            }

            function startTimer(duration) {
                var timer = duration, minutes, seconds;
                setInterval(function () {
                    minutes = parseInt(timer / 60, 10);
                    seconds = parseInt(timer % 60, 10);

                    minutes = minutes < 10 ? "0" + minutes : minutes;
                    seconds = seconds < 10 ? "0" + seconds : seconds;
                    $('#timer').text(minutes + ":" + seconds);

                    if (--timer < 0) {
                        clearInterval();
                        $('form').submit(); 
                    }
                }, 1000);
            }

            var startTime = new Date("{{ $quiz->start_time }}").getTime();
            var endTime = new Date("{{ $endTime }}").getTime();
            var currentTime = new Date("{{ $currentTime }}").getTime();
            var remainingTime = Math.floor((endTime - currentTime) / 1000); 

            if (remainingTime > 0) {
                startTimer(remainingTime);
            } else {
                $('#timer').text("Time's up!");
                localStorage.clear();
                $('form').submit(); 
            }
        });
    </script>
</body>
</html>
