import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_crud_app/Services/auth.dart';
import 'package:flutter_crud_app/Menus/authenticate/resetpass.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn(Function toggleView): this.toggleView = toggleView;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final Auth _auth = Auth();
  final _formkey = GlobalKey<FormState>();
  String pass = '';
  String email = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('CRUD'),
      ),
      body: Center(
        child: Form(
          key: _formkey,
          child: ListView(
            padding: const EdgeInsets.symmetric(
                vertical: 50.0
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
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
                    validator: (val) => val!.isEmpty ? 'Enter a password' : null ,
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
                  if(_formkey.currentState!.validate()){
                    dynamic result = await _auth.loginWithEmailAndPassword(email, pass);
                    if(result == null){
                      setState(() {
                        error = 'please supply a valid email and password';
                      });
                    }
                  }
                },
                  child: Text('Sign In')),
              const SizedBox(
                  height: 25.0
              ),
              Text(
                error,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14.0
                ),
              ),
              const SizedBox(
                  height: 5.0
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    text: TextSpan(
                        text: 'Forgot Password?',
                        style: new TextStyle( color: Colors.blue ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
                        }
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Sign Up!',
                      style: new TextStyle( color: Colors.blue ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          widget.toggleView();
                        }
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


