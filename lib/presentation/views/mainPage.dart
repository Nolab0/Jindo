import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greennindo/models/advice.dart';
import 'package:greennindo/presentation/utilities/color.dart';
import 'package:greennindo/presentation/partialViews/adviceCard.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                //TODO: profile picture
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello,",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "UserName",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: 500, //limited by padding of the container
              height: 160,
              decoration: BoxDecoration(
                  gradient: gradient(),
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                          alignment: Alignment.center,
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100)),
                          child: Container(
                            alignment: Alignment.center,
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                gradient: gradient(),
                                borderRadius: BorderRadius.circular(100)),
                            child: Text(
                              "80",
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )),
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        "Congratulation ! You have a really good score. It means that your are aware of the current ecological situation.",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Text("Daily advice:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ScrollConfiguration(
                behavior: NoGlowBehaviour(),
                child: ListView(
                  children: [
                    AdviceCard(
                        advice: Advice(
                            "Take shower less than 5min",
                            4,
                            5,
                            5,
                            false,
                            false,
                            DateTime.now().add(Duration(days: 15)))),
                    AdviceCard(
                      advice: Advice(
                          "Turn off your devices the night",
                          4,
                          8,
                          10,
                          false,
                          false,
                          DateTime.now().add(Duration(days: 2))),
                    ),
                    AdviceCard(
                      advice: Advice("Eat less meat", 1, 10, 8, false, false,
                          DateTime.now().add(Duration(days: 2))),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
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
