import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_app/Services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_crud_app/Services/user.dart';
import 'package:flutter_crud_app/Services/database.dart';
import 'package:flutter_crud_app/Services/loader.dart';

// PhoneFields class to update and show the currently saved phone numbers for the user
class PhoneFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider that is holding the current user instance uid
    final user = Provider.of<MyUser?>(context);
    // FutureBuilder used to get a snapshot of the current user document
    return FutureBuilder<DocumentSnapshot>(
      future: DatabaseService(uid: user!.uid!).userPhones,
      builder: (context, snapshot) {
        // if the data is received for the current user then the screen will be loaded
        if (snapshot.hasData) {
          // Button to open the phone's list
          return ElevatedButton(
            child: Text('Add phone entries'),
            onPressed: () async {
              List<String> persons = await Navigator.push(
                context,
                // Sends the current view to the phone list page
                MaterialPageRoute(
                  builder: (context) => SOF(phones: snapshot.data!['phones'].cast<String>()),
                ),
              );
              if (persons != null) persons.forEach(print);
            },
          );
        }
        // if data is not yet loaded, show a loading wheel
        else{
          return Loader();
        }
      }
    );
  }
}

class SOF extends StatefulWidget {
  SOF({Key? key, this.phones}) : super(key:key);

  // Creates the list that will store the user's phone numbers
  List<String>? phones;

  @override
  _SOFState createState() => _SOFState();
}

class _SOFState extends State<SOF> {

  final Auth _auth = Auth();
  final _formkey = GlobalKey<FormState>();

  // lists to hold the text for each phone text field and the card that has the text field
  var phoneTECs = <TextEditingController>[];
  var cards = <Card>[];
  String error = '';

  // Checks if the given phone number is valid using regex
  bool isPhoneNoValid(String phoneNo) {
    if (phoneNo == null || phoneNo == "") return true;
    final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    return regExp.hasMatch(phoneNo);
  }

  // Used to create a new card instance that displays the phone number to the user
  Card createCard() {
    var phoneController = TextEditingController();
    phoneTECs.add(phoneController);
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // shows the index of the displayed phone number
          Text('phone ${cards.length + 1}'),
            TextFormField(
            controller: phoneController,
            decoration: InputDecoration(labelText: 'Phone Number')),
        ],
      ),
    );
  }

  // executes when the class is initialized
  @override
  void initState() {
    super.initState();

    // returns an empty list if the current user has no phone numbers
    if(widget.phones == null || widget.phones!.isEmpty){
      cards.add(createCard());
    } else {
    // Creates a card for each phone numbers that the user has
      for(int i = 0; i < widget.phones!.length; i++){
        cards.add(createCard());
        phoneTECs[i].text = widget.phones![i];
      }
    }

  }

  // updates the database with any changes that the user has done to their phone numbers
  _onDone(dynamic user, UserData userData) async{
    List<String> entries = [];
    for (int i = 0; i < cards.length; i++) {
      if(phoneTECs[i].text.isNotEmpty) {
        entries.add(phoneTECs[i].text);
      }
    }

    dynamic result = await DatabaseService(uid: user.uid!).updateUserPhone(entries);

    Navigator.pop(context, entries);
  }

  // Main view for the phones list after the user has opened the phones list menu
  @override
  Widget build(BuildContext context) {
    // provider that contains the user data
    final user = Provider.of<MyUser?>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid!).userData,
      builder: (context, snapshot) {
        // Displays the phone list view if there is data to do so
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: cards.length,
                    itemBuilder: (BuildContext context, int index) {
                      return cards[index];
                    },
                  ),
                ),
                Text(
                  error,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.0
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: Text('add new'),
                    onPressed: () => setState(() => cards.add(createCard())),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
            floatingActionButton:
            FloatingActionButton(child: Icon(Icons.done),
              onPressed: () async {
                //Validates phone numbers and updates the database if all numbers are valid
                bool isValidPhoneNumber = true;
                int i = 0;
                while (isValidPhoneNumber && i < phoneTECs.length){
                  isValidPhoneNumber = isPhoneNoValid(phoneTECs[i].text);
                  i++;
                }
                if(isValidPhoneNumber){
                  _onDone(user, snapshot.data!);
                }else{
                  setState(() {
                    error = "One or more phone numbers are invalid";
                  });
                }
              },
            ),
          );
        // Otherwise displays a loading circle
        } else {
          return Loader();
        }
      }
    );
  }
}
