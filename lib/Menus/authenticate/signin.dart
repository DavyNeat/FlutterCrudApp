import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_crud_app/Services/auth.dart';
import 'package:flutter_crud_app/Menus/authenticate/resetpass.dart';

// SignIn class/widget
class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn(Function toggleView): this.toggleView = toggleView;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final Auth _auth = Auth();
  final _formkey = GlobalKey<FormState>();
  // variables to be displayed and assigned on the sign in screen
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
        // Form used to validate user input
        child: Form(
          key: _formkey,
          child: ListView(
            //sets vertical spacing
            padding: const EdgeInsets.symmetric(
              vertical: 50.0
            ),
            children: [
              // email input text field
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
              // password input text field
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
              // Sign in button
              ElevatedButton(
                onPressed: () async{
                  // if the input is valid then attempt a login
                  if(_formkey.currentState!.validate()){
                    dynamic result = await _auth.loginWithEmailAndPassword(email, pass);
                    // if the user could not log in, then provide the user with an error
                    if(result == null){
                      setState(() {
                        error = 'please supply a valid email and password';
                      });
                    }
                  }
                },
                  child: Text('Sign In')),
              // Sized box to create more spacing
              const SizedBox(
                  height: 25.0
              ),
              // Text field to display the error to the user
              Text(
                error,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14.0
                ),
              ),
              // Sized box to create more spacing
              const SizedBox(
                height: 5.0
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Forgot Password text to redirect user to the forgot password screen
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
                  // Sign up text to redirect user to the registration screen
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


