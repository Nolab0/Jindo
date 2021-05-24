//custom class of user, get only the uid from firebase user
class CustUser {
  String uid;
  CustUser({this.uid});
}

//data of the current user of the app
class UserData {
  String uid;
  String name;
  int score;
  //TODO: add list of current habit
  UserData({this.uid, this.name, this.score});
}
