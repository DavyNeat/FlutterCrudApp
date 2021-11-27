import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_app/Menus/authenticate/register.dart';
import 'package:flutter_crud_app/Menus/authenticate/signin.dart';


// Authenticate class represents the screen that the user sees while not signed in
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  // The first screen that the user sees is the sign in screen
  bool onSignIn = true;

  // Switches which screen the user would be viewing
  void toggleView(){
    setState(() => onSignIn = (!onSignIn));
  }

  @override
  // Decides which screen is being viewed via the onSignIn variable
  Widget build(BuildContext context) {
    if (onSignIn){
      return SignIn(toggleView);
    } else {
      return register(toggleView);
    }
  }
}
