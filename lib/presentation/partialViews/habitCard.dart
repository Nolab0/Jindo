import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greennindo/models/habit.dart';
import 'package:greennindo/presentation/utilities/color.dart';
import 'package:greennindo/presentation/utilities/gradientButton.dart';

//Class for habit card in the main page
class HabitCard extends StatefulWidget {
  final Habit habit;
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
    if (daysRemaining - (habit.objectiveTimes - habit.currentTimes) < 0) {
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
      padding: EdgeInsets.fromLTRB(8, 15, 8, 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Text(daysRemaining.toString() + " " + day + " remaining",
                  style: TextStyle(
                    color: daysRemaining > 2 ? Colors.black : Colors.red,
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                width: 200,
                child: LinearProgressIndicator(
                    minHeight: 6,
                    backgroundColor: Colors.grey[300],
                    color: daysRemaining > 2 ? Colors.green : Colors.red,
                    value: daysRemaining / habit.delay),
              )
            ],
          ),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: habit.finished
                ? GestureDetector(
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
                : impossible
                    ? GestureDetector(
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
                    : GestureDetector(
                        child: GradientButton(
                          width: 80,
                          height: 45,
                          gradient:
                              habit.doneToday ? whiteGradient() : gradient(),
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
                                    if (habit.currentTimes ==
                                        habit.objectiveTimes)
                                      habit.finished = true;
                                  });
                              },
                      )),
      ]),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
    );
  }
}

//Class for habit card in the add page
class HabitCardAdd extends StatelessWidget {
  final Habit habit;
  HabitCardAdd({this.habit});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                habit.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Column(
                children: [
                  Text("Objective: " +
                      habit.objectiveTimes.toString() +
                      " days"),
                  Text("Period: " + habit.delay.toString() + " days")
                ],
              )
            ],
          ),
          Row(
            children: [
              Text("Difficulty: "),
              SizedBox(
                width: 150,
                child: LinearProgressIndicator(
                  minHeight: 8,
                  backgroundColor: Colors.grey[300],
                  color: Colors.red[300],
                  value: habit.difficulty / 10,
                ),
              ),
              Text(
                " + " + habit.gainedPoints.toString(),
                style: TextStyle(color: Colors.green),
              ),
              Text(" / "),
              Text("- " + habit.loosePoints.toString(),
                  style: TextStyle(color: Colors.red))
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(
              color: habit.selected ? Colors.green : Colors.white, width: 2),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
