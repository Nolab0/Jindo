import 'package:flutter/cupertino.dart';
import 'package:greennindo/business_logic/auth.dart';
import 'package:greennindo/data_access/database.dart';
import 'package:greennindo/models/user_data.dart';
import 'package:greennindo/presentation/views/loading.dart';
import 'package:greennindo/presentation/views/mainPage.dart';
import 'package:greennindo/presentation/views/survey.dart';
import 'package:greennindo/presentation/views/welcomePage.dart';

//Wrap the user in the welcome page if not logged-in, wrap in main page or survey otherwhise
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          if (snapshot.data is CustUser && snapshot.data != null) {
            CustUser user = snapshot.data;
            return StreamBuilder(
              stream: DatabaseService(uid: user.uid).userData,
              builder: (context, snapshot) {
                if (snapshot.data != null && !snapshot.data.surveyDone) {
                  return Survey();
                } else {
                  return MainPage();
                }
              },
            );
          }
          return WelcomePage(); //user not logged-in
        });
  }
}
