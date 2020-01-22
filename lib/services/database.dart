import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/models/user.dart';
import 'package:firebase_app/models/user_doc.dart';

class DatabaseService {
  DatabaseService({this.uid});

  final String uid;

  //collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future updateUserData(String name, String bio, int age) async {
    try {
      return await userCollection
          .document(uid)
          .setData({'name': name, 'bio': bio, 'age': age});
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // user doc from a snapshot
  List<UserDoc> _userDocFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserDoc(
        name: doc.data['name'] ?? '',
        bio: doc.data['bio'] ?? '',
        age: doc.data['age'] ?? 0,
      );
    }).toList();
  }

  // get user stream
  Stream<List<UserDoc>> get user {
    return userCollection.snapshots().map(_userDocFromSnapshot);
  }

  // user data from a snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      userId: uid,
      name: snapshot.data['name'],
      bio: snapshot.data['bio'],
      age: snapshot.data['age'],
    );
  }

  // get user data
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
