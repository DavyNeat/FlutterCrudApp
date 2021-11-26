import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_crud_app/Services/user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference nameCollection = FirebaseFirestore.instance.collection("UserInfo");

  Future registerUserData (String name, String address, String gender, String email)async{
    return nameCollection.doc(uid).set({
      'name': name,
      'address': address,
      'gender': gender,
      'email': email,
      'phones': ['']
    });
  }

  Future updateUserData (String name, String address, String gender, String email)async{
    return nameCollection.doc(uid).update({
      'name': name,
      'address': address,
      'gender': gender,
      'email': email
    });
  }

  Future updateUserPhone (List<String> phones) async{
    return nameCollection.doc(uid).update({
      'phones': phones
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

  List<String> _userPhonesFromSnapshot(DocumentSnapshot snapshot){
    return snapshot['phones'] ?? [''];
  }

  Stream<UserData> get userData {
    return nameCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future<DocumentSnapshot> get userPhones{
    return nameCollection.doc(uid).get();
  }


}