import 'package:greennindo/models/question.dart';

//Class that contain data for the survey
class SurveyData {
  int totalQuestions; //number of questions
  List<Question> questions;

  SurveyData({this.totalQuestions, this.questions});

  //Return a surveydata from a json string (hardcoded 10 for testing)
  SurveyData.fromJson(Map<String, dynamic> json) : totalQuestions = 10;

  //Init the data of the survey to initial data
  void initSurvey(List<dynamic> questionJson) {
    questions = [];
    questions = questionJson
        .map((questionJson) => Question.fromJson(questionJson))
        .toList();
    //initalize each question
    for (int i = 0; i < questions.length; i++) {
      Map<String, dynamic> questionDecode = questionJson[i];
      questions[i].initQuestion(
          questionDecode['answers'],
          questionDecode['correspondingPoints'],
          questionDecode['questionType']);
    }
  }
}
