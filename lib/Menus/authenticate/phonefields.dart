import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_crud_app/Services/auth.dart';


class PhoneFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Add entries'),
      onPressed: () async {
        List<String> persons = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SOF(),
          ),
        );
        if (persons != null) persons.forEach(print);
      },
    );
  }
}

class SOF extends StatefulWidget {
  @override
  _SOFState createState() => _SOFState();
}

class _SOFState extends State<SOF> {
  var phoneTECs = <TextEditingController>[];
  var cards = <Card>[];

  Card createCard() {
    var phoneController = TextEditingController();
    phoneTECs.add(phoneController);
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('phone ${cards.length + 1}'),
          TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone Number')),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    cards.add(createCard());
  }

  _onDone() {
    List<String> entries = [];
    for (int i = 0; i < cards.length; i++) {
      entries.add(phoneTECs[i].text);
    }
    Navigator.pop(context, entries);
  }

  @override
  Widget build(BuildContext context) {
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
      FloatingActionButton(child: Icon(Icons.done), onPressed: _onDone),
    );
  }
}
