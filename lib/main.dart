import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_app/Menus/authenticate/authenticate.dart';
import 'package:flutter_crud_app/Services/user.dart';
import 'package:flutter_crud_app/Services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_crud_app/Menus/home/home.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// Main function used to call the main widget
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// First widget to be called, creates the Stream provider to call the uid in other widgets
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: Auth().user,
      initialData: null,
      child: MaterialApp(
          home: Wrapper()
      ),
    );
  }
}

// Wrapper widget to decide between the user home screen and the authenticate screens
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);

    // returns the authenticate screens if there is no user, otherwise shows the home screen
    if (user?.uid == null){
      return Authenticate();
    } else {
      return Home();
    }
  }
}
