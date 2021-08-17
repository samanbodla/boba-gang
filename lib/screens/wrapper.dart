//  deals with authenticate and home

import 'package:boba_gang/screens/authenticate/authenticate.dart';
import 'package:boba_gang/screens/home/home.dart';
import 'package:boba_gang/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);  //  retrieve the user data
    print(user);


    //  return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}

