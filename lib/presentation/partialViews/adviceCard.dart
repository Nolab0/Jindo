import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greennindo/models/advice.dart';
import 'package:greennindo/presentation/utilities/color.dart';

class AdviceCard extends StatefulWidget {
  Advice advice;
  AdviceCard({@required this.advice});
  @override
  _AdviceCardState createState() => _AdviceCardState();
}

class _AdviceCardState extends State<AdviceCard> {
  Advice advice;
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                Container(
                  width: 280,
                  child: LinearProgressIndicator(
                      minHeight: 10,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      value: advice.currentTimes / advice.objectiveTimes),
                ),
                Text(
                  "+ " + advice.points.toString() + "pt",
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
                      " remaining to apply the advice",
                  style: TextStyle(
                      fontSize: 13,
                      color: daysRemaining <= 2 ? Colors.red : Colors.black),
                ),
              ),
            if (advice.finished)
              Container(
                  width: 200, //limited by the padding
                  child: OutlinedButton(
                    onPressed: () {
                      //TODO: go to screen to choose new advice
                    },
                    child: Text("Finish advice",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green[400]),
                    ),
                  ))
            else if (impossible)
              OutlinedButton(
                onPressed: () {
                  //TODO: go to screen to choose new advice
                },
                child: Text(
                  "Advice failed",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange[700])),
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
                        fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                    backgroundColor: advice.doneToday
                        ? MaterialStateProperty.all<Color>(Colors.white)
                        : MaterialStateProperty.all<Color>(Colors.green[400]),
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
