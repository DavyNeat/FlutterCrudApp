import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_crud_app/Services/auth.dart';
import 'package:flutter_crud_app/Menus/authenticate/phonefields.dart';


class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  _registerState createState() => _registerState();
}
enum Genders { Man, Woman, Other }

class _registerState extends State<register> {

  Genders? _gender = Genders.Man;

  final Auth _auth = Auth();
  String pass = '';
  String email = '';
  String phone = '';
  String name = '';
  String address = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('CRUD'),
      ),
      body: Center(
        child: Form(
          child: ListView(
            padding: const EdgeInsets.symmetric(
                vertical: 50.0
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (val){
                    setState(() {
                      email = val;
                    });
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'nota@real.email'
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                    onChanged: (val){
                      setState(() {
                        pass = val;
                      });
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'str0ngpa55w0rd'
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                    onChanged: (val){
                      setState(() {
                        name = val;
                      });
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'your name'
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                    onChanged: (val){
                      setState(() {
                        address = val;
                      });
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                        hintText: 'Rainbow Road'
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('Man'),
                      leading: Radio<Genders>(
                        value: Genders.Man,
                        groupValue: _gender,
                        onChanged: (Genders? value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Woman'),
                      leading: Radio<Genders>(
                        value: Genders.Woman,
                        groupValue: _gender,
                        onChanged: (Genders? value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Other'),
                      leading: Radio<Genders>(
                        value: Genders.Other,
                        groupValue: _gender,
                        onChanged: (Genders? value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                    ),
                  ],
                )
              ),
              PhoneFields(),
              ElevatedButton(
                  onPressed: () async{
                    dynamic result = await _auth.signInAnon();

                    print(email);
                    print(pass);

                  },
                  child: Text('Sign In')),
              const SizedBox(
                  height: 25.0
              ),
              RichText(
                  text: TextSpan(
                      text: 'Sign in Instead',
                      style: new TextStyle( color: Colors.blue ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {print('test135');}
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
