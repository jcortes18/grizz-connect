class Question {
  String qText;
  bool qAns;

  Question(this.qText, this.qAns);
}

class QuizBrain {
  int _qNo = 0;

  final List<Question> _questions = [
    Question(
        'Have you been in contact with anyone that has had a confirmed case of COVID within the past 14 days?',
        false),
    Question(
        'Do you have any symptoms of COVID-19?',
        false),
    Question('Are you isolating or quarantining because you tested positive for COVID-19 or are worried that you may be sick with COVID-19?', false),

  ];

  void nextQuestion() {
    if (_qNo < _questions.length - 1) _qNo++;
  }

  String getQuestion() {
    return _questions[_qNo].qText;
  }

  bool getAnswer() {
    return _questions[_qNo].qAns;
  }

  int getCountOfQuestions() {
    return _questions.length;
  }

  bool isFinished() {
    if (_qNo == _questions.length - 1)
      return true;
    else
      return false;
  }

  void reset() {
    _qNo = 0;
  }
}