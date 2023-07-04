import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<User?> signIn(email, password) async {
  await _auth.signInWithEmailAndPassword(email: email, password: password);
  return (_auth.currentUser);
}

createUser(email, password) async {
  await _auth.createUserWithEmailAndPassword(email: email, password: password);
}

signOut(){
  _auth.signOut();
}