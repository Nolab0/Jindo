import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greennindo/models/habit.dart';
import 'package:greennindo/presentation/utilities/color.dart';

class HabitCard extends StatefulWidget {
  Habit advice;
  HabitCard({@required this.advice});
  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  Habit advice;
  int daysRemaining;
  //if true advice is impossible to do in the remaining time
  bool impossible = false;
  String day = "day"; //singular form

  @override
  void initState() {
    advice = widget.advice;
    daysRemaining = advice.limit.difference(DateTime.now()).inDays;
    if (daysRemaining - advice.objectiveTimes < 0) {
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
                  advice.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    advice.currentTimes.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " / " + advice.objectiveTimes.toString() + " days",
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
                  "- " + advice.loosePoints.toString() + "pt",
                  style: TextStyle(color: Colors.red.withOpacity(0.4)),
                ),
                Container(
                  width: 250,
                  child: LinearProgressIndicator(
                      minHeight: 10,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      value: advice.currentTimes / advice.objectiveTimes),
                ),
                Text(
                  "+ " + advice.gainedPoints.toString() + "pt",
                  style: TextStyle(
                      color: advice.finished
                          ? Colors.black
                          : Colors.black.withOpacity(0.3)),
                )
              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            if (!advice.finished)
              Container(
                width: 150,
                child: Text(
                  daysRemaining.toString() +
                      " " +
                      day +
                      " remaining for the habit",
                  style: TextStyle(
                      fontSize: 13,
                      color: daysRemaining <= 2 ? Colors.red : Colors.black),
                ),
              ),
            if (advice.finished)
              OutlinedButton(
                onPressed: () {
                  //TODO: go to screen to choose new advice
                },
                child: Text("Habit complete !",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    )),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green[500]),
                ),
              )
            else if (impossible)
              OutlinedButton(
                onPressed: () {
                  //TODO: go to screen to choose new advice
                },
                child: Text(
                  "Failed",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red[400])),
              )
            else
              Align(
                alignment: Alignment.topRight,
                child: OutlinedButton(
                  onPressed: advice.doneToday
                      ? null //button disabled
                      : () {
                          if (!advice.doneToday) //button enabled
                            setState(() {
                              advice.doneToday = true;
                              advice.currentTimes++;
                              if (advice.currentTimes == advice.objectiveTimes)
                                advice.finished = true;
                            });
                        },
                  child: Text(
                    advice.doneToday ? "Done for today" : "I dit it !",
                    style: TextStyle(
                      color: advice.doneToday
                          ? Colors.black.withOpacity(0.5)
                          : Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                    backgroundColor: advice.doneToday
                        ? MaterialStateProperty.all<Color>(Colors.white)
                        : MaterialStateProperty.all<Color>(Colors.green[500]),
                  ),
                ),
              )
          ])
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
    );
  }
}
