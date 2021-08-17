//  customizing the user into my own preferences

class User {

  final String uid;

  User({this.uid}); //  (constructor) auto apply the uid

}

class UserData {

  final String uid;
  final String name;
  final int sugars;
  final String flavor;
  final String boba;

  UserData({ this.uid, this.name, this.sugars, this.flavor, this.boba });

}