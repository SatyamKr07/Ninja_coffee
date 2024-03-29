import 'package:firebase_auth/firebase_auth.dart';
import 'package:tnn_ff/models/user.dart';
import 'package:tnn_ff/screens/home/home.dart';
import 'package:tnn_ff/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
//create custom user obj with only required properties based on Firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user)=>_userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("signInAnon error:$e");
      return null;
    }
  }

  //register user with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      //create user with uid
      await DatabaseService(uid: user.uid)
          .updateUserData('0', 'new crew member', 100);
      print('reg successful');
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('error registering');
      print(e.toString());
      return null;
    }
  }

  // sign in user
  Future signInEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('error registering');
      print(e.toString());
      return null;
    }
  }

  //sign out anon
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
