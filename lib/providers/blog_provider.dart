import 'package:doctor_green/models/blogs_model.dart';
import 'package:doctor_green/services/network.dart';
import 'package:flutter/material.dart';

class BlogProvider extends ChangeNotifier {
  BlogsModel? blog;

  likeOrDislike(String userId, {required BuildContext context}) async {
    if (blog != null) {
      final likeStatus = blog!.isLiked;
      blog?.isLiked = !likeStatus;
      notifyListeners();
      try {
        await addToFavourite(blog!.id, userId);
        print("added");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              likeStatus ? "removed from favorites" : "Added to favorites",
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      } catch (e) {
        print("Something went wrong");
        blog?.isLiked = likeStatus;
      }
    }
  }
}
