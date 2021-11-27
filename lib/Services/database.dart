import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_crud_app/Services/user.dart';

// Database class to interact with the Firebase database
class DatabaseService{
  // The user id
  final String uid;
  DatabaseService({required this.uid});

  // The collection of all user data
  final CollectionReference nameCollection = FirebaseFirestore.instance.collection("UserInfo");

  // Creates a new document in the database for the registered user
  Future registerUserData (String name, String address, String gender, String email)async{
    return nameCollection.doc(uid).set({
      'name': name,
      'address': address,
      'gender': gender,
      'email': email,
      'phones': ['']
    });
  }

  // Updates the data in the database for the current user
  Future updateUserData (String name, String address, String gender, String email)async{
    return nameCollection.doc(uid).update({
      'name': name,
      'address': address,
      'gender': gender,
      'email': email
    });
  }

  // Updates the phone data in the database for the current user
  Future updateUserPhone (List<String> phones) async{
    return nameCollection.doc(uid).update({
      'phones': phones
    });
  }

  // Creates a User data object from the database data
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot['name'] ?? '',
      address: snapshot['address'] ?? '',
      gender: snapshot['gender'] ?? '',
      email: snapshot['email'] ?? ''
    );
  }

  // returns a stream for the user data
  Stream<UserData> get userData {
    return nameCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // returns a future for the user's phone numbers data
  Future<DocumentSnapshot> get userPhones{
    return nameCollection.doc(uid).get();
  }
}