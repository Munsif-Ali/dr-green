import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  String? id;
  String? email;
  String? name;
  String? photoUrl;
  bool? isAdmin;
  List<String>? favoriteProducts;
  List<String>? favoriteBlogs;
  // final bool isEmailVerified;
  AuthUser(
      {this.id,
      this.email,
      this.name,
      this.photoUrl,
      this.isAdmin,
      this.favoriteProducts,
      this.favoriteBlogs
      // required this.isEmailVerified,
      });

  AuthUser.fromJson(Map<String, dynamic> json) {
    favoriteProducts = json['favorite_products']?.cast<String>();
    name = json['name'];
    favoriteBlogs = json['favorite_blogs']?.cast<String>();
    isAdmin = json['isAdmin'] ?? false;
    email = json['email'];
    id = json['id'];
  }
  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["isAdmin"] = isAdmin;
    data["photoUrl"] = photoUrl;
    return data;
  }

  factory AuthUser.fromFirebase(User user) => AuthUser(
        id: user.uid,
        email: user.email!,
        name: user.displayName!,
        photoUrl: user.photoURL,
        // isEmailVerified: user.emailVerified,
      );
}
