import 'package:boba_gang/screens/wrapper.dart';
import 'package:boba_gang/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  //  allows us to listen to streams
import 'package:boba_gang/models/user.dart';

void main() { runApp(MyApp());}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return StreamProvider<User>.value(    //  specify what stream we want to listen to and what data we want to get back
      value: AuthServices().user,         //  create an instance of authservice and accessing the user stream
      child: MaterialApp(
      home: Wrapper(),                    //  the user stream is now accessible by the root wrapper
      ),
    );
    
  }
}
