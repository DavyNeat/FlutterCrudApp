import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_app/Menus/authenticate/authenticate.dart';
import 'package:flutter_crud_app/Services/user.dart';
import 'package:flutter_crud_app/Services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_crud_app/Menus/home/home.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseService{

  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference nameCollection = FirebaseFirestore.instance.collection("UserInfo");

  Future updateUserData (String name, String address, String gender, String email)async{

    return nameCollection.doc(uid).set({
      'name': name,
      'address': address,
      'gender': gender,
      'email': email
    });

  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot['name'] ?? '',
      address: snapshot['address'] ?? '',
      gender: snapshot['gender'] ?? '',
      email: snapshot['email'] ?? ''
    );
  }

  Stream<UserData> get userData {
    return nameCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }


}