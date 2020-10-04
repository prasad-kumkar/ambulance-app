import 'package:flutter/material.dart';
import 'package:my_app/screens/authenticate/register.dart';
import 'package:my_app/screens/home/home.dart';
import 'package:my_app/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field states
  String email = '';
  String password = '';
  String error = '';

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
                "User Sign In \n",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Password',
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
                  child: Text('Sign in', style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      try {
                        dynamic result = await _auth.signInWithEmailPassword(
                            email, password);
                      } catch (e) {
                        error = 'Could not sign in with those credentials';
                        print(error);
                      }
                    }
                  }),
              SizedBox(height: 20),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.purple[100])),
                  color: Colors.purple[300],
                  child: Text('Create a new account',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    widget.toggleView();
                  }),
              Text(error)
            ])),

        /*child: RaisedButton(
            child: Text("Sign in as a Guest"),
            onPressed: () async {
              dynamic result = await _auth.signInAnon();
              print(result);
              if (result == null) {
                print('Error Signing in');
              } else {
                print('Signed In');
                return Home();
              }
            }),*/
      ),
    );
  }
}
