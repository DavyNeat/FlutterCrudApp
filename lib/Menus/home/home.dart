import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_app/Services/database.dart';
import 'package:flutter_crud_app/Services/user.dart';
import 'package:flutter_crud_app/Services/auth.dart';
import 'package:flutter_crud_app/Menus/authenticate/phonefields.dart';
import 'package:provider/provider.dart';
import 'package:flutter_crud_app/Services/loader.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Auth _auth = Auth();
  final _formkey = GlobalKey<FormState>();

   Genders? _gender;
   String? email;
   String? phone;
   String? name;
   String? address;
   String? error;
   String? strGender;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid!).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('CRUD'),
              ),
              body: Form(
                key: _formkey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                      vertical: 50.0
                  ),
                  children: [
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
                        PhoneFields(),
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
          } else {
            return Loader();
          }
        }
    );

  }
}
