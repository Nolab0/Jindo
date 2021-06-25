import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greennindo/business_logic/auth.dart';
import 'package:greennindo/models/user_data.dart';
import 'package:greennindo/presentation/views/finishedhabtis.dart';

class UserPage extends StatelessWidget {
  final UserData userData; //pass the user data in parameter
  final AuthService _auth = AuthService();

  UserPage({@required this.userData});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
            Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userData.name, style: TextStyle(fontSize: 30)),
                    Text("Green padawan",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black.withOpacity(0.5))),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        children: [
                          OptionLine(
                              title: "Completed habits",
                              icon: Icons.check,
                              color: Colors.green,
                              iconColor: Colors.green[800],
                              redirection: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FinishedHabits(
                                            finished: userData.completedHabits,
                                          )))),
                          OptionLine(
                            title: "Progression",
                            icon: Icons.show_chart,
                            color: Colors.blue,
                            iconColor: Colors.blue[800],
                            redirection: () => print("OOF"),
                          ),
                          OptionLine(
                            title: "Achievements",
                            icon: Icons.school,
                            color: Colors.amber[400],
                            iconColor: Colors.amber[900],
                            redirection: () => print("OOF"),
                          ),
                          OptionLine(
                              title: "Sign out",
                              icon: Icons.logout,
                              color: Colors.red,
                              iconColor: Colors.red[800],
                              redirection: () => _auth.signOut())
                        ],
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 110),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Text("Jindo release 0.1", style: TextStyle(fontSize: 12)),
                    Text("Made by Nolab and ShakaTuga",
                        style: TextStyle(fontSize: 12))
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

//Widget for the option line
class OptionLine extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final Function redirection;
  OptionLine(
      {this.title, this.icon, this.color, this.iconColor, this.redirection});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  width: 45,
                  height: 45,
                  child: Icon(
                    icon,
                    color: color,
                  ),
                  decoration: BoxDecoration(
                      color: color.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          GestureDetector(
            child: Container(
              width: 40,
              height: 40,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8)),
            ),
            onTap: () {
              redirection();
            },
          )
        ],
      ),
    );
  }
}
