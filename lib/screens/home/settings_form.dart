import 'package:firebase_app/services/database.dart';
import 'package:firebase_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/models/user.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<int> ages = [20, 21, 22, 23, 24, 34];

  String _currentName;
  String _currentBio;
  int _currentAge;

  // testing how a slider work
  // int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.userId).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

              UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your user settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Flexible(
                    flex: 2,
                    child: TextFormField(
                      initialValue: userData.name,
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white70,
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(color: Colors.white38)),
                      onChanged: (value) {
                        setState(() => _currentName = value);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Flexible(
                    flex: 2,
                    child: TextFormField(
                      initialValue: userData.bio,
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white70,
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your bio' : null,
                      decoration: InputDecoration(
                          hintText: 'Bio',
                          hintStyle: TextStyle(color: Colors.white38)),
                      onChanged: (value) {
                        setState(() => _currentBio = value);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 0.0,
                  ),
                  // Flexible(
                  //   flex: 2,
                  //   child: Slider(
                  //     min: 100,
                  //     max: 900,
                  //     divisions: 8,
                  //     activeColor: Colors.yellow[_currentStrength ?? 100],
                  //     inactiveColor: Colors.blueGrey[_currentStrength ?? 100],
                  //     value: (_currentStrength ?? 100).toDouble(),
                  //     onChanged: (value) {
                  //       setState(() => _currentStrength = value.round());
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  DropdownButtonFormField(
                    value: _currentAge ?? userData.age,
                    items: ages.map((age) {
                      return DropdownMenuItem(
                        value: age,
                        child: Text('$age'),
                      );
                    }).toList(),
                    onChanged: (int value) {
                      setState(() => _currentAge = value);
                    },
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
                        child: Text('Update'),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.userId).updateUserData(
                              _currentName ?? userData.name,
                              _currentBio ?? userData.bio,
                              _currentAge ?? userData.age,
                            );
                            Navigator.pop(context);
                          }
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
