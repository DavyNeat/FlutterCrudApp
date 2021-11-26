import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_crud_app/Services/user.dart';
import 'package:flutter_crud_app/Services/auth.dart';


class register extends StatefulWidget {

  final Function toggleView;
  register(Function toggleView): this.toggleView = toggleView;

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {

  final Auth _auth = Auth();
  final _formkey = GlobalKey<FormState>();

  Genders? _gender = Genders.Other;
  String pass = '';
  String email = '';
  String phone = '';
  String name = '';
  String address = '';
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
                  validator: (val) => val!.isEmpty ? 'Enter a valid email' : null ,
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
                    validator: (val) => val!.length > 6 ? 'Enter a valid password (>6 chars)' : null ,
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
                    validator: (val) => val!.isEmpty ? 'Enter a name' : null ,
                    onChanged: (val){
                      setState(() {
                        name = val;
                      });
                    },
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
                    validator: (val) => val!.isEmpty ? 'Enter an address' : null ,
                    onChanged: (val){
                      setState(() {
                        address = val;
                      });
                    },
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
              ElevatedButton(
                onPressed: () async{
                  if (_formkey.currentState!.validate()){
                    String strGender = MyUser().genderToString(_gender);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, pass, name, address, strGender);
                    if(result == null){
                      setState(() {
                        error = 'please supply a valid email and password';
                      });
                    }
                  }
                },
                child: Text('Register')),
                const SizedBox(
                height: 25.0
              ),
              Text(
                error,
                textAlign: TextAlign.center,
                style: TextStyle(
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
                      text: 'Sign In!',
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
