import 'package:doctor_green/services/authentication/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  AuthUser? get currentUser;
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String name,
  });
  Future<void> logOut();
  // Future<void> sendEmailVerification();
}
