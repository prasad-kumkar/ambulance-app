import 'package:flutter/material.dart';
import 'package:my_app/screens/authenticate/sign_in.dart';
import 'package:my_app/screens/authenticate/authenticate.dart';
import 'package:my_app/services/auth.dart';
import 'package:email_validator/email_validator.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool isEmailValid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
            key: _formKey,
            child: Column(children: [
              SizedBox(height: 40),
              Text(
                "Welcome! \n\nCreate an new account",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.grey[300],
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 3)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple[900]))),
                validator: (value) => value.contains('@') && value.contains('.')
                    ? null
                    : 'Enter a valid email',
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.grey[300],
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 3)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple[900]))),
                validator: (val) =>
                    val.length < 6 ? 'Enter a password 6+ chars long' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.purple[100])),
                  color: Colors.purple[300],
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      try {
                        dynamic result = await _auth.registerWithEmailPassword(
                            email, password);
                      } catch (e) {
                        error = 'Please enter a valid email';
                      }
                    }
                  }),
              SizedBox(height: 20),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.purple[100])),
                  color: Colors.purple[300],
                  child: Text('Sign in to an existing account',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    widget.toggleView();
                  }),
            ])),
      ),
    );
  }
}
