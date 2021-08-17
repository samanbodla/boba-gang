// for directly dealing with authentication

import 'package:boba_gang/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:boba_gang/models/user.dart';

class AuthServices {

  //  an instance of the firebase authentication
  //  its not gonna change in the future and private, only for this file
  final FirebaseAuth _auth = FirebaseAuth.instance; 

  //  create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //  the user stream to detect sign in/sign out
  //  returns a User
  Stream<User> get user {
    return _auth.onAuthStateChanged
      //  change FirebaseUser to the customized User
      //  .map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);  //  does the same thing
  }

  //  sign in anon
  //  check flutter for beginners for future
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user); //returns the custom user
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //  sign in with email and pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //  register with email and pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //  create a new document for the user
      await DataBaseService(uid: user.uid).updateUserData(0,'new member', '', 'no');

      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //  sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}

