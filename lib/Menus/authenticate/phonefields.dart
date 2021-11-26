import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_app/Services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_crud_app/Services/user.dart';
import 'package:flutter_crud_app/Services/database.dart';
import 'package:flutter_crud_app/Services/loader.dart';


class PhoneFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return FutureBuilder<DocumentSnapshot>(
      future: DatabaseService(uid: user!.uid!).userPhones,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data!['phones']);
          return ElevatedButton(
            child: Text('Add phone entries'),
            onPressed: () async {
              List<String> persons = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SOF(phones: snapshot.data!['phones'].cast<String>()),
                ),
              );
              if (persons != null) persons.forEach(print);
            },
          );
        }
        else{
          return Loader();
        }
      }
    );
  }
}

class SOF extends StatefulWidget {
  SOF({Key? key, this.phones}) : super(key:key);

  List<String>? phones;

  @override
  _SOFState createState() => _SOFState();
}

class _SOFState extends State<SOF> {

  final Auth _auth = Auth();
  final _formkey = GlobalKey<FormState>();

  var phoneTECs = <TextEditingController>[];
  var cards = <Card>[];


  bool isPhoneNoValid(String? phoneNo) {
    if (phoneNo == null) return true;
    final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    return regExp.hasMatch(phoneNo);
  }

  Card createCard() {
    var phoneController = TextEditingController();
    phoneTECs.add(phoneController);
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('phone ${cards.length + 1}'),
            TextFormField(
            validator: (val) => isPhoneNoValid(val) ? 'Enter a valid phone number' : null ,
            controller: phoneController,
            decoration: InputDecoration(labelText: 'Phone Number')),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    if(widget.phones == null || widget.phones!.isEmpty){
      cards.add(createCard());
    } else {
      for(int i = 0; i < widget.phones!.length; i++){
        cards.add(createCard());
        phoneTECs[i].text = widget.phones![i];
      }
    }

  }

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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid!).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(),
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: cards.length,
                      itemBuilder: (BuildContext context, int index) {
                        return cards[index];
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      child: Text('add new'),
                      onPressed: () => setState(() => cards.add(createCard())),
                    ),
                  )
                ],
              ),
              floatingActionButton:
              FloatingActionButton(child: Icon(Icons.done),
                onPressed: () async {
                  _onDone(user, snapshot.data!);
                },
              ),
            );
          } else {
            return Loader();
          }
        }
    );
  }
}
