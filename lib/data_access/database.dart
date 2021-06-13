import 'dart:convert';

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
      'name': name,
      'score': score,
      'surveyDone': done,
      'habits': habits.map((e) => e.toJson()).toList()
    });
  }

  //Update only the habits of the user
  Future updateUserHabits(List<Habit> habits) async {
    return await usersData
        .doc(uid)
        .update({'habits': habits.map((e) => e.toJson()).toList()});
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
    return data;
  }

  //get user_data stream
  Stream<UserData> get userData {
    return usersData.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
