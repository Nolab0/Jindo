//custom class of user, get only the uid from firebase user
import 'package:greennindo/models/habit.dart';

class CustUser {
  String uid;
  CustUser({this.uid});
}

//data of the current user of the app
class UserData {
  String uid;
  String name;
  int score;
  bool surveyDone; //true if the user has done the launch survey
  List<Habit>
      habits; //current habits of the user (don't need to be init via the constructor)
  List<Habit> completedHabits;
  UserData(
      {this.uid, this.name, this.score, this.surveyDone, this.completedHabits});
}
