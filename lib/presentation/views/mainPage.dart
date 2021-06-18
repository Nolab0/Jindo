import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greennindo/business_logic/auth.dart';
import 'package:greennindo/data_access/database.dart';
import 'package:greennindo/models/habit.dart';
import 'package:greennindo/models/user_data.dart';
import 'package:greennindo/presentation/utilities/color.dart';
import 'package:greennindo/presentation/partialViews/habitCard.dart';
import 'package:greennindo/presentation/views/habitePage.dart';
import 'package:greennindo/presentation/views/loading.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AuthService _auth = AuthService();
  List<Habit> habits = [];

  bool empty = true; //true if the user has no habit to do7

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustUser>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          habits = userData.habits;
          if (habits.length > 0) {
            empty = false;
          } else {
            empty = true;
          }
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
                      alignment: Alignment.center,
                      //TODO: profile picture
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(25)),
                      child: IconButton(
                          icon: Icon(Icons.person),
                          color: Colors.white,
                          onPressed: () async {
                            await _auth.signOut();
                          }),
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
                        userData.name,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
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
                                    userData.score.toString(),
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
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Text("Habits:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  if (empty)
                    Container(
                      height: 300,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("You don't have habit to take at the moment",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 1.4,
                                  color: Colors.black.withOpacity(0.5))),
                          Text("Add an habit to start",
                              style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 1.4,
                                  color: Colors.black.withOpacity(0.5))),
                          FloatingActionButton(
                            child: Container(
                              width: 60,
                              height: 60,
                              child: Icon(Icons.add),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, gradient: gradient()),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HabitSelection(
                                          currentHabits: habits)));
                            },
                          )
                        ],
                      ),
                    )
                  else
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ScrollConfiguration(
                                behavior: NoGlowBehaviour(),
                                child: ListView.builder(
                                  itemCount: habits.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return HabitCard(habit: habits[index]);
                                  },
                                )),
                          ),
                          habits.length < 3
                              ? Container(
                                  margin: EdgeInsets.symmetric(vertical: 15),
                                  child: FloatingActionButton(
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      child: Icon(Icons.add),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: gradient()),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HabitSelection(
                                                      currentHabits: habits)));
                                    },
                                  ))
                              : Container()
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ));
        } else {
          return Loading();
        }
      },
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
