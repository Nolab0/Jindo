import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greennindo/models/habit.dart';
import 'package:greennindo/presentation/utilities/color.dart';
import 'package:greennindo/presentation/utilities/gradientButton.dart';

class HabitCard extends StatefulWidget {
  Habit habit;
  HabitCard({@required this.habit});
  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  Habit habit;
  int daysRemaining;
  //if true advice is impossible to do in the remaining time
  bool impossible = false;
  String day = "day"; //singular form

  @override
  void initState() {
    habit = widget.habit;
    daysRemaining = habit.limit.difference(DateTime.now()).inDays;
    if (daysRemaining - habit.objectiveTimes < 0) {
      impossible = true;
    }
    if (daysRemaining > 1) {
      day = "days"; //plural form
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 230, //to display remaining days
                child: Text(
                  habit.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    habit.currentTimes.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " / " + habit.objectiveTimes.toString() + " days",
                    style: TextStyle(
                        decoration: impossible
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.4)),
                  )
                ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 12, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "- " + habit.loosePoints.toString() + "pt",
                  style: TextStyle(color: Colors.red.withOpacity(0.4)),
                ),
                Container(
                  width: 250,
                  child: LinearProgressIndicator(
                      minHeight: 10,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      value: habit.currentTimes / habit.objectiveTimes),
                ),
                Text(
                  "+ " + habit.gainedPoints.toString() + "pt",
                  style: TextStyle(
                      color: habit.finished
                          ? Colors.black
                          : Colors.black.withOpacity(0.3)),
                )
              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            if (!habit.finished)
              Container(
                width: 150,
                child: Text(
                  daysRemaining.toString() + " " + day + " to go",
                  style: TextStyle(
                      fontSize: 13,
                      color: daysRemaining <= 2 ? Colors.red : Colors.black),
                ),
              ),
            if (habit.finished)
              GestureDetector(
                child: GradientButton(
                  width: 150,
                  height: 50,
                  border: false,
                  gradient: gradient(),
                  text: Text("Habit complete !",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                ),
                onTap: () {
                  //TODO: redirect to habit choose screen
                },
              )
            else if (impossible)
              GestureDetector(
                child: GradientButton(
                  border: false,
                  width: 80,
                  height: 45,
                  gradient: redGradient(),
                  text: Text(
                    "Failed",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                onTap: () {
                  //TODO: redirect to loose point screen
                },
              )
            else
              Align(
                  alignment: Alignment.topRight,
                  child: (GestureDetector(
                    child: GradientButton(
                      width: 80,
                      height: 45,
                      gradient: habit.doneToday ? whiteGradient() : gradient(),
                      border: habit.doneToday,
                      text: Text(
                        habit.doneToday ? "Done for today" : "I dit it !",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: habit.doneToday
                              ? Colors.black.withOpacity(0.5)
                              : Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    onTap: habit.doneToday
                        ? null //button disabled
                        : () {
                            if (!habit.doneToday) //button enabled
                              setState(() {
                                habit.doneToday = true;
                                habit.currentTimes++;
                                if (habit.currentTimes == habit.objectiveTimes)
                                  habit.finished = true;
                              });
                          },
                  )))
          ])
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
    );
  }
}
