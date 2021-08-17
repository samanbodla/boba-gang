//  manages the bobalist and settings 
//  stateless widget

import 'package:boba_gang/screens/home/settings.dart';
import 'package:boba_gang/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:boba_gang/services/database.dart';
import 'package:provider/provider.dart';
import 'package:boba_gang/screens/home/brew_list.dart';
import 'package:boba_gang/models/boba.dart';

class Home extends StatelessWidget {

  //  needed to log out
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Boba>>.value(
        value: DataBaseService().bobas, // this stream is used
        child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.blueGrey[800],
          elevation: 0.0,
          title: Text('Boba Gang'),

          actions: <Widget>[

            FlatButton.icon(
              icon: Icon(
                Icons.settings, 
                color: Colors.white),
              label: Text (
                'settings',
                style: TextStyle(color: Colors.white)
                ),
              onPressed: () =>  Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings())),
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.person, 
                color: Colors.white),
              label: Text (
                'logout',
                style: TextStyle(color: Colors.white)
                ),
              onPressed: () async {
                await _auth.signOut();
              },
            )

          ],

        ),
        
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg1.jpg'),
              fit: BoxFit.cover,
            )
          ),
          child: BrewList()
        ),
        
        
      ),
    );
  }
}