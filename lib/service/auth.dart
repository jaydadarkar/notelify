import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = result.user;
      return _user;
    } catch (e) {
      return 500;
    }
  }

  Future register(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user = result.user;
      return _user;
    } catch (e) {
      return 500;
    }
  }
}
