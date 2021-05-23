import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

List items = [
  {
    "header": "Get your ecological score an take new habits ",
    "description":
        "Online chat which provides its users maximum functionality to simplify the search",
    "image": "assets/images/appView.png"
  },
  {
    "header": "Get your ecological score an take new habits ",
    "description":
        "Online chat which provides its users maximum functionality to simplify the search",
    "image": "assets/images/progress.png"
  },
  {
    "header": "Get your ecological score an take new habits ",
    "description":
        "Online chat which provides its users maximum functionality to simplify the search",
    "image": "assets/images/walking.png"
  },
];

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  //slide list
  List<Widget> slides = items
      .map((item) => Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 25),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Image.asset(
                  item['image'],
                  fit: BoxFit.fitWidth,
                  width: 450.0,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: <Widget>[
                      Text(item['header'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                        item['description'],
                        style: TextStyle(
                          color: Colors.grey,
                          letterSpacing: 1.2,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              )
            ],
          )))
      .toList();

//Bottom indicator
  List<Widget> indicator() => List<Widget>.generate(
      slides.length,
      (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            height: 10.0,
            width: 10.0,
            decoration: BoxDecoration(
                color: currentPage.round() == index
                    ? Colors.green
                    : Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0)),
          ));

  double currentPage = 0.0;
  final _pageViewController = new PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Stack(
            children: <Widget>[
              Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Hello ! ",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )),
              PageView.builder(
                controller: _pageViewController,
                itemCount: slides.length,
                itemBuilder: (BuildContext context, int index) {
                  _pageViewController.addListener(() {
                    setState(() {
                      currentPage = _pageViewController.page;
                    });
                  });
                  return slides[index];
                },
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 70.0),
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: indicator(),
                        ),
                      ),
                      Text(
                        "Before starting, Gindo needs to have some information about you and your current habits",
                        style: TextStyle(
                          color: Colors.grey,
                          letterSpacing: 1.2,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          "Get started",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700]),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
