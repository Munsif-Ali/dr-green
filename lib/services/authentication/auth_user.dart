import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  // final bool isEmailVerified;
  const AuthUser({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    // required this.isEmailVerified,
  });
  factory AuthUser.fromFirebase(User user) => AuthUser(
        id: user.uid,
        email: user.email!,
        name: user.displayName!,
        photoUrl: user.photoURL,
        // isEmailVerified: user.emailVerified,
      );
}
