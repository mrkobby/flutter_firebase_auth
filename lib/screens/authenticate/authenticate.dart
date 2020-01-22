import 'package:firebase_app/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignInPage = true;

  void toogleView() {
    setState(() {
      showSignInPage = !showSignInPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignInPage){
      return SignIn(toggleView: toogleView,);
    }else{
      return Register(toggleView: toogleView);
    }
  }
}