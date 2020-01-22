import 'package:firebase_app/models/user.dart';
import 'package:firebase_app/screens/wrapper.dart';
import 'package:firebase_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: Wrapper(),
      ),
      value: AuthService().user,
    );
  }
}
