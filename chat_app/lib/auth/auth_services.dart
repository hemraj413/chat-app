import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;

Future<User?> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  if (googleUser == null) {
    // The user canceled the sign-in
    return null;
  }

  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final UserCredential userCredential = await auth.signInWithCredential(credential);
  return userCredential.user;
}
