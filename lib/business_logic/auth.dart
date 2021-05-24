import 'package:firebase_auth/firebase_auth.dart';
import 'package:greennindo/data_access/database.dart';
import 'package:greennindo/models/user_data.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CustUser _userFromFirebaseUser(User user) {
    return user != null ? CustUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<CustUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData("Thibault", 88);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("Log-in anonymously error : " + e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
