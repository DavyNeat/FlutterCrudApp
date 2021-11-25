import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_crud_app/Services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final Auth _auth = Auth();
  String pass = '';
  String email = '';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    text: TextSpan(
                        text: 'Forgot Password?',
                        style: new TextStyle( color: Colors.blue ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {print('test246');}
                    ),
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Sign Up!',
                          style: new TextStyle( color: Colors.blue ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {print('test135');}
                      )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


