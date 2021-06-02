import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greennindo/models/survey_data.dart';
import 'package:greennindo/data_access/database.dart';
import 'package:greennindo/models/question.dart';
import 'package:greennindo/models/user_data.dart';
import 'package:greennindo/presentation/views/mainPage.dart';

//Load the survey from a JSON file
Future<SurveyData> loadSurvey() async {
  String json = await rootBundle.loadString("assets/data/survey.json");
  Map<String, dynamic> jsonDecoded = jsonDecode(json);
  SurveyData data = SurveyData.fromJson(jsonDecoded);
  data.initSurvey(jsonDecoded['questions']);
  return data;
}

//Return the score according to the answer of the question
int updateScore(SurveyData survey, int questionIndex, int currentScore) {
  Question question = survey.questions[questionIndex];
  int score = question.correspondingPoints[question.answerIndex()];
  currentScore += score;
  return currentScore;
}

//Update the name of the user
void updateName(
    UserData userData, SurveyData survey, int questionIndex, String name) {
  Question question = survey.questions[questionIndex];
  question.answer = name;
  DatabaseService(uid: userData.uid).updateUserData(name, 50);
}

//Finish the survey, save the score in firebase and redirect to the main page
void finishSurvey(UserData userData, int finalScore, BuildContext context) {
  DatabaseService(uid: userData.uid).updateUserData(userData.name, finalScore);
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => MainPage()));
}
