import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_app/Services/database.dart';
import 'package:flutter_crud_app/Services/user.dart';
import 'package:flutter_crud_app/Services/auth.dart';
import 'package:flutter_crud_app/Menus/authenticate/phonefields.dart';
import 'package:provider/provider.dart';
import 'package:flutter_crud_app/Services/loader.dart';
// Home class/widget to display the user's home screen after they have logged in
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Auth _auth = Auth();
  final _formkey = GlobalKey<FormState>();
  // variables to be updated and viewed in the home screen
  Genders? _gender;
  String? email;
  String? phone;
  String? name;
  String? address;
  String? error;
  String? strGender;

  @override
  Widget build(BuildContext context) {
    // Provider used to get the uid
    final user = Provider.of<MyUser?>(context);
    // Stream builder used to get the current user data
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid!).userData,
        builder: (context, snapshot) {
          // Displays the home screen when the data has been loaded
          if (snapshot.hasData) {
            UserData userData = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('CRUD'),
              ),
              // Form used to validate text in the home screen
              body: Form(
                key: _formkey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                      vertical: 50.0
                  ),
                  children: [
                    // Text field for the user's email
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        enabled: false,
                        initialValue: userData.email,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'nota@real.email'
                        ),
                      ),
                    ),
                    // Text field for the user's password
                    // Always invisible to the user
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        enabled: false,
                        initialValue: '****',
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'str0ngpa55w0rd'
                        )
                      ),
                    ),
                    // Input text field where user can view and update their name
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          initialValue: userData.name,
                          validator: (val) => val!.isEmpty ? 'Enter a name' : null,
                          onChanged: (val) {
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
                    // Input text field where user can view and update their address
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                          initialValue: userData.address,
                          validator: (val) => val!.isEmpty ? 'Enter an address' : null,
                          onChanged: (val) {
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
                    // editable radio buttons where user can update their gender
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
                                    _gender = value!;
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
                                    _gender = value!;
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
                                    _gender = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Displays button the redirects to the phones list screen
                        PhoneFields(),
                        // Displays button that updates the user data from their home screen
                        ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()){
                              String strGender = MyUser().genderToString(_gender);
                              dynamic result = await DatabaseService(uid: user.uid!).updateUserData(
                                  name ?? userData.name,
                                  address ?? userData.address,
                                  strGender,
                                  email ?? userData.email);
                              if(result == null){
                                setState(() {
                                  error = 'please supply a valid email';
                                });
                              }
                            }
                          },
                          child: Text('Update Information'))
                      ],
                    ),
                    // Button used to sign the user out
                    ElevatedButton(
                        onPressed: () async {
                          await _auth.signOut();
                        },
                        child: Text('Sign Out')
                    ),
                  ],
                ),
              ),
            );
          // Displays a loading circle while the data is not yet loaded
          } else {
            return Loader();
          }
        }
    );

  }
}
