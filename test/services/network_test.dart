import 'package:doctor_green/models/blogs_model.dart';
import 'package:doctor_green/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:doctor_green/services/network.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  group('Network Tests', () {
    test('getPosts should return a list of BlogsModel', () async {
      final posts = await getPosts();
      expect(posts, isA<List<BlogsModel>>());
    });

    test('getFavoritePosts should return a list of BlogsModel', () async {
      final userId = 'someUserId';
      final favoritePosts = await getFavoritePosts(userId);
      expect(favoritePosts, isA<List<BlogsModel>>());
    });

    test('getProducts should return a list of ProductModel', () async {
      final products = await getProducts();
      expect(products, isA<List<ProductModel>>());
    });

    test('getFavoriteProducts should return a list of ProductModel', () async {
      final userId = 'someUserId';
      final favoriteProducts = await getFavoriteProducts(userId);
      expect(favoriteProducts, isA<List<ProductModel>>());
    });

    test('getPrediction should return a Map<String, dynamic>', () async {
      final imageFile = XFile('path/to/image');
      final prediction = await getPrediction(imageFile);
      expect(prediction, isA<Map<String, dynamic>>());
    });

    test('removeOrAddToFavourite should update user data in Firestore',
        () async {
      final blogId = 'someBlogId';
      final userId = 'someUserId';
      await removeOrAddToFavourite(blogId, userId);
      // You can add more assertions here to check if the user data was updated correctly
    });
  });
}
