import 'dart:convert';

import 'package:doctor_green/constants/globals_variables.dart';
import 'package:doctor_green/models/blogs_model.dart';

Future<List<BlogsModel>> getPosts() async {
  ("getPosts called");
  // get blogs from firestore
  try {
    final response = await firebaseFirestore.collection('blogs').get();
    ('response: $response');
    final List<BlogsModel> posts = [];
    ("response.docs: ${response.docs}");
    for (final doc in response.docs) {
      final data = doc.data();
      ("data: ${jsonEncode(data)}");
      final BlogsModel post = BlogsModel.fromJson(data);
      ("post: ${post.title}");
      ("test");
      posts.add(post);
    }
    ("posts: ${posts.length}");
    ("first post: ${posts.first.title}");

    return posts;
  } catch (e) {
    ("error: $e");
    return [];
  }
}
