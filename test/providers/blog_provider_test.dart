import 'package:doctor_green/models/blogs_model.dart';
import 'package:doctor_green/providers/blog_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends BuildContext with Mock {}

void main() {
  group('BlogProvider', () {
    test('likeOrDislike toggles like status', () {
      final blogProvider = BlogProvider();
      const userId = 'user123';
      final blog = BlogsModel(id: 'blog123', isLiked: false);

      blogProvider.blog = blog;

      // Provide a valid BuildContext, for example, using a MaterialApp widget.
      final context = MockBuildContext(); // Create a mock context

      blogProvider.likeOrDislike(userId, context: context);

      expect(blogProvider.blog!.isLiked,
          true); // The like status should be toggled

      // Reset the state to the initial state (disliked)
      blogProvider.likeOrDislike(userId, context: context);

      expect(blogProvider.blog!.isLiked,
          false); // The like status should be toggled back
    });

    test('likeOrDislike handles exception', () {
      final blogProvider = BlogProvider();
      const userId = 'user123';
      final blog = BlogsModel(id: 'blog123', isLiked: false);

      blogProvider.blog = blog;

      // Provide a valid BuildContext, for example, using a MaterialApp widget.
      final context = MockBuildContext();

      expect(() {
        blogProvider.likeOrDislike(userId, context: context);
      }, throwsA(isA<Exception>()));

      // The like status should remain unchanged
      expect(blogProvider.blog!.isLiked, false);
    });
  });
}
