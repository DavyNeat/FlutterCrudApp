import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_crud_app/Services/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

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

  //register

  //logout
  Future signOut() async{
    try {
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}