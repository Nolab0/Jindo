import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greennindo/models/habit.dart';
import 'package:greennindo/models/user_data.dart';

class DatabaseService {
  final String uid; //pass the uid of the user
  DatabaseService({this.uid});

  //Collection reference
  final CollectionReference usersData =
      FirebaseFirestore.instance.collection("users_data");

  //Update all the field of userData
  Future updateUserData(
      String name, int score, bool done, List<Habit> habits) async {
    return await usersData.doc(uid).set({
      'userId': uid,
      'name': name,
      'score': score,
      'surveyDone': done,
      'habits': habits.map((e) => e.toJson()).toList(),
      'habitsCompleted': []
    });
  }

  //Update only the score of a user
  Future updateScore(int score) async {
    return await usersData.doc(uid).update({'score': score});
  }

  //Update only the habits of the user
  Future updateUserHabits(List<Habit> habits) async {
    return await usersData
        .doc(uid)
        .update({'habits': habits.map((e) => e.toJson()).toList()});
  }

  Future updateUserCompletedHabits(List<Habit> completed) async {
    return await usersData
        .doc(uid)
        .update({'habitsCompleted': completed.map((e) => e.toJson()).toList()});
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    UserData data = UserData(
        uid: uid,
        name: snapshot['name'],
        score: snapshot['score'],
        surveyDone: snapshot['surveyDone']);
    data.habits = snapshot['habits'].map<Habit>((e) {
      return Habit.fromFirestore(e);
    }).toList();
    data.completedHabits = snapshot['habitsCompleted'].map<Habit>((e) {
      return Habit.fromFirestore(e);
    }).toList();
    return data;
  }

  //get user_data stream
  Stream<UserData> get userData {
    return usersData.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  List<UserData> _listUserDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      UserData data = UserData(
          uid: doc['userId'],
          name: doc['name'],
          score: doc['score'],
          surveyDone: doc['surveyDone']);
      return data;
    }).toList();
  }

  Stream<List<UserData>> get allUserData {
    return usersData.snapshots().map(_listUserDataFromSnapshot);
  }
}
