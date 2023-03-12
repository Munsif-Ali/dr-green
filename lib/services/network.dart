import 'dart:convert';

import 'package:doctor_green/models/blogs_model.dart';
import 'package:http/http.dart' as https;

Future<List<BlogsModel>> getPosts() async {
  final response =
      await https.get(Uri.parse("https://dummyjson.com/posts?limit=10"));
  List<BlogsModel> posts = [];
  if (response.statusCode == 200) {
    final List rawPosts = jsonDecode(response.body)["posts"];
    posts = rawPosts.map((post) => BlogsModel.fromJson(post)).toList();
  }

  return posts;
}
