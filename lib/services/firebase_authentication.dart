import 'dart:convert';

import 'package:doctor_green/constants/globals_variables.dart';
import 'package:doctor_green/providers/user_provider.dart';
import 'package:doctor_green/services/authentication/auth_provider.dart';
import 'package:doctor_green/services/authentication/auth_user.dart';
import 'package:doctor_green/services/exceptions/auth_exception.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;
import 'package:provider/provider.dart';
import '../../firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.android,
    );
  }

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        await value.user!.updateDisplayName(name);
      });
      final user = currentUser;
      if (user != null) {
        // store user data in firestore
        await FirebaseFirestore.instance.collection('users').doc(user.id).set({
          'name': name,
          'email': email,
          "isAdmin": false,
        });

        // save user data in shared preferences
        await storeUserDataInSharedPref();
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        await storeUserDataInSharedPref();
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  // @override
  // Future<void> sendEmailVerification() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     await user.sendEmailVerification();
  //   } else {
  //     throw UserNotLoggedInAuthException();
  //   }
  // }

  Future storeUserDataInSharedPref() async {
    final user = currentUser;
    if (user != null && user.id != null) {
      final userData =
          (await firebaseFirestore.collection("users").doc(user.id).get())
              .data();
      await sharedPreferences?.setString("user", jsonEncode(userData));
    } else {
      throw UserNotLoggedInAuthException();
    }
  }
}
