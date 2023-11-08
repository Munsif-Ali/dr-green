import 'dart:convert';

import 'package:doctor_green/constants/globals_variables.dart';
import 'package:doctor_green/models/blogs_model.dart';
import 'package:doctor_green/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

const baseUrl = "https://85hmt33n-8000.inc1.devtunnels.ms/";

Future<List<BlogsModel>> getPosts() async {
  ("getPosts called");
  // get blogs from firestore
  try {
    final response = await firebaseFirestore.collection('blogs').get();
    final List<BlogsModel> posts = [];
    for (final doc in response.docs) {
      final data = doc.data();
      final BlogsModel post = BlogsModel.fromJson(data);
      posts.add(post);
    }
    return posts;
  } catch (e) {
    debugPrint("error: $e");
    return [];
  }
}

Future<List<BlogsModel>> getFavoritePosts(String userId) async {
  try {
    // Get the favorite ids list from the user collection.
    final favoriteIds = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then(
          (value) => value.data()?["favorite_blogs"].toList(),
        );
    // Get the blogs from the blogs collection that match the favorite ids.
    final blogs = await FirebaseFirestore.instance
        .collection('blogs')
        .where('id', whereIn: favoriteIds)
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => BlogsModel.fromJson(doc.data()))
            .toList());

    return blogs;
  } catch (e) {
    return [];
  }
}

Future<List<ProductModel>> getProducts() async {
  ("getPosts called");
  // get blogs from firestore
  try {
    final response = await firebaseFirestore.collection('products').get();
    final List<ProductModel> products = [];
    for (final doc in response.docs) {
      final data = doc.data();
      final ProductModel product = ProductModel.fromJson(data);
      products.add(product);
    }
    return products;
  } catch (e) {
    return [];
  }
}

Future<List<ProductModel>> getFavoriteProducts(String userId) async {
  // Get the favorite ids list from the user collection.
  final favoriteIds = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .get()
      .then(
        (value) => value.data()?["favorite_products"].toList(),
      );

  // Get the blogs from the blogs collection that match the favorite ids.
  final blogs = await FirebaseFirestore.instance
      .collection('products')
      .where('id', whereIn: favoriteIds)
      .get()
      .then((snapshot) => snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList());

  return blogs;
}

Future<Map<String, dynamic>> getPrediction(XFile imageFile) async {
  // final respoose =
  //     await https.post(Uri.parse("http://10.48.25.189:8000/predict"));
  try {
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}predict'));
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final results = await response.stream.bytesToString();

      final jsonData = jsonDecode(results);
      return jsonData;
    } else {
      throw Exception("Somtehing went wrong");
    }
  } catch (e) {
    rethrow;
  }
}

Future removeOrAddToFavourite(String? blogId, String userId) async {
  // Reference to the Firestore collection containing user data
  final userCollection = FirebaseFirestore.instance.collection('users');

  // Reference to the specific user's document
  final userDocRef = userCollection.doc(userId);

  // Fetch user's data from Firestore
  DocumentSnapshot userSnapshot = await userDocRef.get();
  Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

  // Get the current list of favorite blogs from the user's data
  List<String> favoriteBlogs =
      List<String>.from(userData['favorite_blogs'] ?? []);

  // Check if the blogId is already in the favorites
  if (favoriteBlogs.contains(blogId)) {
    // If the blog is already in favorites, remove it
    favoriteBlogs.remove(blogId);

    // Also remove the user's ID from the blog's likes array
    final blogDocRef =
        FirebaseFirestore.instance.collection('blogs').doc(blogId);
    await blogDocRef.update({
      'likes': FieldValue.arrayRemove([userId]),
    });
  } else {
    // If the blog is not in favorites, add it
    favoriteBlogs.add(blogId!);

    // Also add the user's ID to the blog's likes array
    final blogDocRef =
        FirebaseFirestore.instance.collection('blogs').doc(blogId);
    await blogDocRef.update({
      'likes': FieldValue.arrayUnion([userId]),
    });
  }

  // Update the user's favorite blogs in Firestore
  await userDocRef.update({'favorite_blogs': favoriteBlogs});
}
