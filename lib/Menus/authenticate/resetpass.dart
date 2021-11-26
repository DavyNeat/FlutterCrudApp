import 'package:flutter/material.dart';
import 'package:flutter_crud_app/Services/database.dart';
import 'package:flutter_crud_app/Services/user.dart';
import 'package:flutter_crud_app/Menus/authenticate/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword extends StatelessWidget {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Reset Password'),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'email@to.reset'
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                FirebaseAuth.instance.sendPasswordResetEmail(email: controller.text);
                controller.text = '';
                AlertDialog dialog = AlertDialog(
                  title: Text('Reset Sent'),
                  content: Text('A password reset has been sent to the given email, if one exists.'),
                  elevation: 24.0,
                  backgroundColor: Colors.blue,
                );
                showDialog(
                  context: context,
                  builder: (_) => dialog,
                );
              },
              child: Text('reset')
            )
          ],
        ),
      ),
    );
  }
}
