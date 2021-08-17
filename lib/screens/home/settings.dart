import 'package:boba_gang/models/user.dart';
import 'package:boba_gang/services/database.dart';
import 'package:boba_gang/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:boba_gang/shared/constants.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final _formKey = GlobalKey<FormState>();
  final List<String> bobas = ['no', 'yes'];

  String _currentName;
  int _currentSugar;
  String _currentFlavor;
  String _currentBoba;
  
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);  //wrapper allows this

    return StreamBuilder<UserData>(
      stream: DataBaseService(uid: user.uid).userData,
      builder: (context, snapshot) {

        if (snapshot.hasData) {

          UserData userData = snapshot.data;

          return Scaffold(
            backgroundColor: Colors.deepPurple[100],

            appBar: AppBar(
              backgroundColor: Colors.deepPurple[300],
              elevation: 0.0,
              title: Text('update boba preferences'),
            ),

            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      
                      SizedBox(height: 20.0),

                      TextFormField(
                        initialValue: userData.name,
                        decoration: textInputDecoration.copyWith(hintText: 'your name'),
                        validator: (val) => val.isEmpty ? 'enter name' : null,
                        onChanged: (val) { setState(() => _currentName = val);}      
                      ),

                      SizedBox(height: 20.0),

                      TextFormField(
                        initialValue: userData.flavor,
                        decoration: textInputDecoration.copyWith(hintText: 'flavor'),
                        validator: (val) => val.isEmpty ? 'enter name' : null,
                        onChanged: (val) { setState(() => _currentFlavor = val);}      
                      ),

                      SizedBox(height: 20.0),

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          Expanded(
                            child: Text('boba: ', style: TextStyle(fontSize: 17.0))
                          ),
                          
                          Expanded(
                            child: DropdownButtonFormField(
                            decoration: textInputDecoration,
                            value: _currentBoba ?? userData.boba,
                            items: bobas.map((boba){
                              return DropdownMenuItem(
                                value: boba,
                                child: Text( '$boba'),
                              );
                            }).toList(),
                            onChanged: (val) => setState(() => _currentBoba = val),
                            )
                          )

                        ]
                      ),

                      SizedBox(height: 20.0),

                      Slider(
                        value: (_currentSugar ?? userData.sugars).toDouble(),
                        activeColor: Colors.deepPurple[300],
                        inactiveColor: Colors.deepPurple[200],
                        label: _currentSugar == null ? '${userData.sugars}% sugar' : '$_currentSugar% sugar',
                        min: 0,
                        max: 100,
                        divisions: 4,
                        onChanged: (val) => setState(() => _currentSugar = val.round()),
                        ),

                      SizedBox(height: 20.0),

                      RaisedButton(
                        color: Colors.deepPurple[300],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await DataBaseService(uid: user.uid).updateUserData(
                                _currentSugar ?? userData.sugars,
                                _currentName ?? userData.name,
                                _currentFlavor ?? userData.flavor,
                                _currentBoba ?? userData.boba );
                            }

                            Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                )  
              )
            )
          );
        }
      else { return Loading(); }
      }
    );
  }
}


    