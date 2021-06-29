import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greennindo/models/habit.dart';
import 'package:greennindo/presentation/partialViews/habitCard.dart';

class FinishedHabits extends StatelessWidget {
  final List<Habit> finished;
  FinishedHabits({this.finished});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your completed habits: ",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text("Congratulations, you have completed " +
                        finished.length.toString() +
                        " habits"),
                    ScrollConfiguration(
                      behavior: NoGlowBehaviour(),
                      child: Expanded(
                        child: ListView.builder(
                          itemCount: finished.length,
                          itemBuilder: (BuildContext context, int index) {
                            return HabitCardFinished(
                              habit: finished[index],
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//class for removing the glow from the scrolling part
class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
