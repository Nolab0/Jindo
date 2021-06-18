import 'package:flutter/material.dart';
import 'package:greennindo/models/habit.dart';
import 'package:greennindo/models/user_data.dart';
import 'package:greennindo/presentation/utilities/color.dart';

//Alert dialog when an habit is completed or failed
AlertDialog habitDialog(Habit habit, BuildContext context, UserData userData) {
  return AlertDialog(
    title: Center(
        child: Text(habit.finished ? "Congratulations !" : "What a shame !")),
    content: SingleChildScrollView(
        child: ListBody(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: 90,
            height: 90,
            decoration: BoxDecoration(
                gradient: gradient(), borderRadius: BorderRadius.circular(100)),
            child: Text(
              userData.score.toString(),
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Icon(
            Icons.arrow_right_alt,
            color: habit.finished ? Colors.green : Colors.red[400],
            size: 80,
          ),
          Container(
            alignment: Alignment.center,
            width: 90,
            height: 90,
            decoration: BoxDecoration(
                gradient: gradient(), borderRadius: BorderRadius.circular(100)),
            child: Text(
              habit.finished
                  ? (userData.score + habit.gainedPoints).toString()
                  : (userData.score - habit.loosePoints).toString(),
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: Text(habit.finished
            ? "Continue on this path, you get a new ecological habit !"
            : "Don't discourage yourself, you can try again to complete this habit"),
      )
    ])),
    actions: [
      TextButton(
        child: Text(
          "Continue",
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
