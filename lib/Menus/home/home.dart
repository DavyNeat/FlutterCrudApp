import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_app/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('CRUD'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(
              vertical: 50.0
          ),
          children: [
            ElevatedButton(
                onPressed: () async{
                  await _auth.signOut();
                },
                child: Text('Sign Out')
            ),
          ],
        ),
      ),
    );
  }
}
