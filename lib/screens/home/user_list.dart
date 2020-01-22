import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_app/models/user_doc.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<List<UserDoc>>(context) ?? [];

    return ListView.builder(
      itemCount: user.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.blueGrey[200],
              ),
              title: Text('${user[index].name}'),
              subtitle: Text('${user[index].bio}'),
              trailing: Text('${user[index].age}'),
            ),
          ),
        );
      },
    );
  }
}
