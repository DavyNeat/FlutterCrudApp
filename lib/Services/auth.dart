import 'package:flutter_crud_app/Services/database.dart';
import 'package:flutter_crud_app/Services/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? _userFromFirebaseUser(User? user){
    return (user != null) ? MyUser(uid: user.uid) : null;
  }

  //login anon
  Future signInAnon() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    }catch(e){
      return null;
    }
  }

  //change user stream
  Stream<MyUser?> get user{
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //login
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

  //register
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

  //logout
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