import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ResetPassword class/widget to display the reset password screen
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
            // Sizedbox to create empty space
            SizedBox(
              height: 25.0,
            ),
            // Input textfield for target account email
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
            // Button to initiate password reset
            ElevatedButton(
              onPressed: (){
                //sends password reset request
                FirebaseAuth.instance.sendPasswordResetEmail(email: controller.text);
                //resets text field
                controller.text = '';
                // Dialog box to notify the user that a password request has been sent if the email exists
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
