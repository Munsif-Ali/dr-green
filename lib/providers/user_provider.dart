import 'package:doctor_green/services/authentication/auth_service.dart';
import 'package:doctor_green/services/authentication/auth_user.dart';
import 'package:flutter/material.dart';

class UserProivder extends ChangeNotifier {
  AuthUser user = AuthService.firebase().currentUser ?? AuthUser();

  void changeUserInfo({
    String? name,
    String? email,
    String? id,
    bool? isAdmin,
  }) {
    user.name = name ?? user.name;
    user.email = email ?? user.email;
    user.id = id ?? user.id;
    user.isAdmin = isAdmin ?? user.isAdmin;
    notifyListeners();
  }
}
