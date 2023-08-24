import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static Future<bool> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
    return true;
  }

  static signup({
    required String name,
    required String email,
    required String password,
  }) {
    try {
      print("Name: $name, Email: $email, Password: $password");
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        value.user!.updateDisplayName(name);
        print("user created");
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      print(e.message);
      return false;
    }
    return true;
  }
}
