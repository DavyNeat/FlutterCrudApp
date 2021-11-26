
enum Genders { Man, Woman, Other }

class MyUser {

  final String? uid;
  MyUser({this.uid});

  String genderToString(Genders? gender){
    if (gender == Genders.Man){
      return 'Man';
    } else if (gender == Genders.Woman){
      return 'Woman';
    } else {
      return 'Other';
    }
  }

  Genders stringToGender(String? gender){
    if (gender == 'Man'){
      return Genders.Man;
    } else if (gender == 'Woman'){
      return Genders.Woman;
    } else {
      return Genders.Other;
    }
  }
}

class UserData{

  String uid;
  String name;
  String address;
  String gender;
  String email;

  UserData({required this.uid, required this.name, required this.address, required this.gender, required this.email});

}
