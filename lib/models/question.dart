//enumeration of the type of questions
enum questionType { textfield, mcq }

class Question {
  String question;
  List<String> answers; //for mcq questions
  String answer; //for textfield questions
  List<bool> answerMarks;
  List<int> correspondingPoints;
  questionType type;

  Question(
      {this.question,
      this.answers,
      this.answerMarks,
      this.correspondingPoints,
      this.type});

  //Methods

  questionType stringToType(String s) {
    switch (s) {
      case "mcq":
        return questionType.mcq;
        break;
      case "textField":
        return questionType.textfield;
        break;
    }
    return questionType.mcq; // default
  }

  //Return a question from a json string
  Question.fromJson(Map<String, dynamic> json) : question = json['question'];

  //Init the question with initial value
  void initQuestion(
      List<dynamic> answerList, List<dynamic> pointList, dynamic questiontype) {
    answers = [];
    correspondingPoints = [];
    answerMarks = [];
    type = stringToType(questiontype.toString());
    answer = "";
    //init answers
    for (int i = 0; i < answerList.length; i++) {
      answers.add(answerList[i].toString());
      correspondingPoints.add(int.parse(pointList[i]));
      answerMarks.add(false);
    }
  }

  //Return the index of the answers is selected
  int answerIndex() {
    for (int i = 0; i < answerMarks.length; i++) {
      if (answerMarks[i]) {
        return i;
      }
    }
    return answerMarks.length;
  }

  //Reinit all the answer list to false, ensure that only one answer is true at each time
  void markAnswer(int index) {
    for (int i = 0; i < answers.length; i++) {
      if (i == index) {
        answerMarks[i] = !answerMarks[i];
      } else {
        answerMarks[i] = false;
      }
    }
  }

  //return if a question is answered or not
  bool isAnswered() {
    if (type == questionType.textfield && answer != "") {
      return true;
    }
    bool res = false;
    for (int i = 0; i < answerMarks.length && !res; i++) {
      if (answerMarks[i]) {
        res = true;
      }
    }
    return res;
  }
}
