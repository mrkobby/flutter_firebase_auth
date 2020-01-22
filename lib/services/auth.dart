
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_app/models/user.dart';
import 'database.dart';

class AuthService{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //obj of user class asigned to firebaseAuth user
  User _userFromFirebaseConsole(FirebaseUser user){
      return user != null ? User(userId: user.uid) : null;
  }

  //auth listen to stream and get logged in user
  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebaseConsole);
  }

  // user anonymous login
  Future signInAnonymous() async {
    try{
      AuthResult authResult = await _firebaseAuth.signInAnonymously();
      FirebaseUser firebaseUser =  authResult.user;
      return _userFromFirebaseConsole(firebaseUser);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //user email/pass login
  Future loginWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseConsole(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


  //user email/pass resgister
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // create a new document for the user with the UID
      await DatabaseService(uid: user.uid).updateUserData('Kwabena', 'Life is beans', 34);
      return _userFromFirebaseConsole(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


  //user signout
  Future signoutUser() async{
    try{
      return await _firebaseAuth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

}