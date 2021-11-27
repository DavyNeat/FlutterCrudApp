import 'package:flutter_crud_app/Services/database.dart';
import 'package:flutter_crud_app/Services/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Auth class that is used to communicate with the Firebase Auth
class Auth{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Returns user data according to the uid
  MyUser? _userFromFirebaseUser(User? user){
    return (user != null) ? MyUser(uid: user.uid) : null;
  }

  // Returns the state of the current user, whether or not a user is logged in
  Stream<MyUser?> get user{
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Logs the user in given their email and password
  Future loginWithEmailAndPassword(String email, String pass) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      User? user = result.user;
      print('logging in');
      print(user!.uid);
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Registers a new user account given user data
  Future registerWithEmailAndPassword(String email, String pass, String name, String address, String gender) async {

    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      User? user = result.user;
      await DatabaseService(uid: user!.uid).registerUserData(name, address, gender, email);
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }

  }

  // Signs the current user out
  Future signOut() async{
    print('signing out');
    try {
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}