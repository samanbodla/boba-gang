import 'package:flutter/material.dart';
import 'package:boba_gang/services/auth.dart';
import 'package:boba_gang/shared/constants.dart';
import 'package:boba_gang/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  
  //  an instance of the AuthServices class in auth.dart
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();  //  global key for the form
  bool loading = false;

  //  text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(

      backgroundColor: Colors.deepPurple[100],

      appBar: AppBar(

        backgroundColor: Colors.deepPurple[300],
        elevation: 0.0,
        title: Text('Sign up for Boba Gang'),

        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white),
            label: Text(
              'Sign In',
              style: TextStyle(color: Colors.white)
              ),
            onPressed: () {
              widget.toggleView();
            }
          )
        ],
      ),

      body: Container(

        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),

        child: Form(
          
          key: _formKey,
          child: Column(
            children: <Widget>[
              
              // email
              SizedBox(height: 20.0),
              
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'ENTER AN EMAIL' : null,
                onChanged: (val) {
                  setState(() => email = val);
                }
              ),
              
              // password
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val.length < 6 ? 'PASSWORD MUST BE LENGTH 6' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                }      
              ),

              //  button to sign up
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.deepPurple[300],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) { //validate the form
                  setState (() => loading = true);
                   dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                   if (result == null) {
                     setState(() {
                       error = 'EMAIL IS NOT VALID';
                       loading = false; 
                      });
                   } 
                  }
                }
              ),

              SizedBox(height: 12.0),
              Text (
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          )
        )
      )
    );
  }
}