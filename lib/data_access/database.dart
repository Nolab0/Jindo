import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greennindo/models/user_data.dart';

class DatabaseService {
  final String uid; //pass the uid of the user
  DatabaseService({this.uid});

  //collection reference

  final CollectionReference usersData =
      FirebaseFirestore.instance.collection("users_data");

  Future updateUserData(String name, int score) async {
    return await usersData.doc(uid).set({'name': name, 'score': score});
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(uid: uid, name: snapshot['name'], score: snapshot['score']);
  }

  //get user_data stream
  Stream<UserData> get userData {
    return usersData.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
