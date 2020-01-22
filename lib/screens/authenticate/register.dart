import 'package:firebase_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //obj of authentication Service Class
  final AuthService _authService = AuthService();

  //boolean variable for screen spinner
  bool showSpinner = false;

  //textformfields values
  String userEmail = '';
  String userPassword = '';
  String userConfirmPassword = '';
  String error = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      progressIndicator: CircularProgressIndicator(
        backgroundColor: Colors.blueGrey[900],
      ),
      child: Scaffold(
        backgroundColor: Colors.blueGrey[200],
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: Text('Create an account'),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Sign in'),
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
                      validator: (val) => val.length < 8
                          ? 'Please enter a password 8+ characters long'
                          : null,
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
                  Flexible(
                    flex: 2,
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      validator: (val) =>
                          val.isEmpty ? 'Please confirm your password' : null,
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(color: Colors.black38)),
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          userConfirmPassword = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Flexible(
                    flex: 2,
                    child: RaisedButton(
                      color: Colors.blueGrey[700],
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Create an account'),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => showSpinner = true);
                          dynamic result =
                              await _authService.registerWithEmailAndPassword(
                                  userEmail, userPassword);
                          if (result == null) {
                            setState(() {
                              showSpinner = false;
                              error = 'Please provide a valid email address';
                            });
                          }
                        }
                      },
                    ),
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
      ),
    );
  }
}
