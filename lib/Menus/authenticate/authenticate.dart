import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_app/Menus/authenticate/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_crud_app/Menus/authenticate/signin.dart';
import 'package:flutter_crud_app/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool onSignIn = true;

  void toggleView(){
    setState(() => onSignIn = (!onSignIn));
  }

  @override
  Widget build(BuildContext context) {
    if (onSignIn){
      return SignIn(toggleView);
    } else {
      return register(toggleView);
    }
  }
}
