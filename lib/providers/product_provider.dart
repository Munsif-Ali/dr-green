import 'package:doctor_green/constants/globals_variables.dart';
import 'package:doctor_green/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  ProductModel? product;

  likeOrDislike(String userId, {required BuildContext context}) async {
    if (product != null) {
      final likeStatus = product!.isLiked;
      product?.isLiked = !likeStatus;
      notifyListeners();
      try {
        await removeOrAddToFavourite(product!.prodId, userId);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                likeStatus ? "removed from favorites" : "Added to favorites",
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        product?.isLiked = likeStatus;
        notifyListeners();
      }
    }
  }
}

Future removeOrAddToFavourite(String? productId, String userId) async {
  // Reference to the Firestore collection containing user data
  final userCollection = FirebaseFirestore.instance.collection('users');

  // Reference to the specific user's document
  final userDocRef = userCollection.doc(userId);

  // Fetch user's data from Firestore
  DocumentSnapshot userSnapshot = await userDocRef.get();
  Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

  // Get the current list of favorite blogs from the user's data
  List<String> favoriteProducts =
      List<String>.from(userData['favorite_products'] ?? []);

  // Check if the blogId is already in the favorites
  if (favoriteProducts.contains(productId)) {
    // If the blog is already in favorites, remove it
    favoriteProducts.remove(productId);

    // Also remove the user's ID from the blog's likes array
    final productDocRef =
        FirebaseFirestore.instance.collection('products').doc(productId);
    await productDocRef.update({
      'likes': FieldValue.arrayRemove([userId]),
    });
  } else {
    // If the blog is not in favorites, add it
    favoriteProducts.add(productId!);

    // Also add the user's ID to the blog's likes array
    final blogDocRef =
        FirebaseFirestore.instance.collection('products').doc(productId);
    await blogDocRef.update({
      'likes': FieldValue.arrayUnion([userId]),
    });
  }

  // Update the user's favorite blogs in Firestore
  await userDocRef.update({'favorite_products': favoriteProducts});
}
