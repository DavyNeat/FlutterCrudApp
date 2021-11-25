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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

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


class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);
    print('userid');
    print(user?.uid);
    if (user?.uid == null){
      print('InAuthenticate');
      return Authenticate();
    } else {
      print('inhome');
      return Home();
    }

    //Return either home or auth

  }
}
