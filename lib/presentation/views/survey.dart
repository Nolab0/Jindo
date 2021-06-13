import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greennindo/models/survey_data.dart';
import 'package:greennindo/business_logic/surveyLogic.dart';
import 'package:greennindo/data_access/database.dart';
import 'package:greennindo/models/question.dart';
import 'package:greennindo/models/user_data.dart';
import 'package:greennindo/presentation/partialViews/answerCard.dart';
import 'package:greennindo/presentation/utilities/color.dart';
import 'package:provider/provider.dart';
import 'loading.dart';

class Survey extends StatefulWidget {
  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  Question current;
  int currentScore = 50; //score starts at 50
  SurveyData survey;
  int currentQuestion = 0; //index of the current question
  bool validation = true;

  Future<SurveyData> loadData() async {
    SurveyData data = await loadSurvey();
    return data;
  }

  //return if the survey if terminated or not
  bool finished() {
    if (currentQuestion + 1 == survey.totalQuestions) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    //Use of provider and stream to get userdata
    final user = Provider.of<CustUser>(context);
    return FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            survey = snapshot.data;
            current = survey.questions[currentQuestion];
            return StreamBuilder<UserData>(
                stream: DatabaseService(uid: user.uid).userData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    UserData userData = snapshot.data;
                    return SafeArea(
                      child: Scaffold(
                        backgroundColor: Colors.grey[100],
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              width: double.infinity,
                              height: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Center(
                                    child: Text(
                                      (currentQuestion + 1).toString() +
                                          " of " +
                                          survey.totalQuestions.toString(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: LinearProgressIndicator(
                                        minHeight: 10,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.green[800]),
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.5),
                                        value: (currentQuestion + 1) /
                                            survey.totalQuestions),
                                  ),
                                  Text(
                                    current.question,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      current.type == questionType.textfield
                                          ? "This name will appear in the public leaderboard"
                                          : "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 1.5,
                                          color: Colors.grey[800])),
                                ],
                              ),
                            ),
                            current.type == questionType.mcq
                                ? McQuestion(question: current)
                                : TField(question: current),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                children: [
                                  Text(validation ? "" : "Missing information",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.red,
                                      )),
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: gradient(),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: OutlinedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0))),
                                        ),
                                        onPressed: () {
                                          if (finished()) {
                                            finishSurvey(userData, currentScore,
                                                context);
                                          }
                                          setState(() {
                                            validation = true;
                                            if (!current.isAnswered()) {
                                              validation = false;
                                            }
                                            if (current.type ==
                                                    questionType.mcq &&
                                                current.isAnswered()) {
                                              //update the score and go the next question
                                              currentScore = updateScore(
                                                  survey,
                                                  currentQuestion,
                                                  currentScore);
                                            } else if (current.type ==
                                                    questionType.textfield &&
                                                current.isAnswered()) {
                                              updateName(
                                                  userData,
                                                  survey,
                                                  currentQuestion,
                                                  current.answer);
                                            }
                                            if (current.isAnswered() &&
                                                !finished()) {
                                              currentQuestion++;
                                            }
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 180,
                                          height: 50,
                                          child: Text(
                                            finished()
                                                ? "Finish"
                                                : "Next Question",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Loading();
                  }
                });
          } else {
            return Loading();
          }
        });
  }
}

//Class for question of type TField
class TField extends StatefulWidget {
  final Question question;
  TField({this.question});
  @override
  _TFieldState createState() => _TFieldState();
}

class _TFieldState extends State<TField> {
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 100,
      child: TextField(
        keyboardType: TextInputType.text,
        maxLines: 1,
        decoration: InputDecoration(
          labelText: "Your name",
          labelStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.green, width: 2)),
        ),
        onChanged: (String s) {
          name = s;
          widget.question.answer = name;
        },
      ),
    );
  }
}

//Class for question of type MCQ
class McQuestion extends StatefulWidget {
  final Question question;

  McQuestion({this.question});

  @override
  _McQuestionState createState() => _McQuestionState();
}

class _McQuestionState extends State<McQuestion> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(), //block the scrolling
        itemCount: widget.question.answers.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Option(
                option: widget.question.answers[index],
                selected: widget.question.answerMarks[index]),
            onTap: () {
              setState(() {
                widget.question.markAnswer(index);
              });
            },
          );
        },
      ),
    );
  }
}
