import 'package:firebase_app/services/auth.dart';
import 'package:firebase_app/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //obj of authentication Service Class
  final AuthService _authService = AuthService();

  //boolean variable for screen spinner
  bool showSpinner = false;

  //textformfields values
  String userEmail = '';
  String userPassword = '';
  String error = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return showSpinner ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Sign in'),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Create an account'),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Flexible(
                  flex: 2,
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter an email address' : null,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.black38)),
                    onChanged: (value) {
                      setState(() {
                        userEmail = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Flexible(
                  flex: 2,
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter your password' : null,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.black38)),
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        userPassword = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  color: Colors.blueGrey[700],
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Sign in'),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        showSpinner = true;
                      });
                      dynamic result = await _authService
                          .loginWithEmailAndPassword(userEmail, userPassword);
                      if (result == null) {
                        setState(() {
                          showSpinner = false;
                          error =
                              'Could not Sign in. Please check credentials';
                        });
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  color: Colors.blue[900],
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Sign in as Anonymous User'),
                  ),
                  onPressed: () async {
                    setState(() => showSpinner = true);
                    dynamic authResult = await _authService.signInAnonymous();
                    if (authResult == null) {
                      error = 'User login failed';
                      print('User login failed!');
                      setState(() => showSpinner = false);
                    } else {
                      print('User login was successful');
                      print(authResult);
                    }
                  },
                ),
                SizedBox(
                  height: 14.0,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
