// enum of genders to use on the radio buttons
enum Genders { Man, Woman, Other }

// User Class/Widget used to store the userid
class MyUser {

  final String? uid;
  MyUser({this.uid});

  // Converts the gender enum value to a string
  String genderToString(Genders? gender){
    if (gender == Genders.Man){
      return 'Man';
    } else if (gender == Genders.Woman){
      return 'Woman';
    } else {
      return 'Other';
    }
  }

  // Converts a given string to the gender enum value
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

// User Class/Widget used to store all user data
class UserData{

  String uid;
  String name;
  String address;
  String gender;
  String email;

  UserData({required this.uid, required this.name, required this.address, required this.gender, required this.email});
}
