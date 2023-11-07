import 'package:doctor_green/constants/globals_variables.dart';
import 'package:doctor_green/extensions/build_context_extensions.dart';
import 'package:doctor_green/models/product_model.dart';
import 'package:doctor_green/providers/cart_provider.dart';
import 'package:doctor_green/providers/product_provider.dart';
import 'package:doctor_green/providers/user_provider.dart';
import 'package:doctor_green/screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final user = Provider.of<UserProivder>(context).user;
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${product.prodName}"),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const CartScreen();
                    },
                  ));
                },
                icon: const Icon(
                  Icons.shopping_cart,
                ),
              ),
              Positioned(
                left: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    "${cart.cartItems.length}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              "${product.prodImage}",
              height: context.getHeight * 0.4,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${product.prodName}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text("RS: ${product.prodPrice}")
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      product.prodCategory != null &&
                              product.prodCategory!.isNotEmpty
                          ? Chip(
                              label: Text("${product.prodCategory}"),
                            )
                          : const SizedBox(),
                      const Spacer(),
                      Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              print(
                                  "user is ${sharedPreferences?.getString("user") ?? "{}"}");
                              print("User ID: ${user.id}");
                              if (user.id != null) {
                                productProvider.likeOrDislike(user.id!,
                                    context: context);
                              }
                            },
                            child: Consumer<ProductProvider>(
                              builder: (context, value, child) {
                                return Column(
                                  children: [
                                    Icon(
                                      value.product?.isLiked ?? false
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                    ),
                                    // Text("${value.blog?.likes?.length}"),
                                  ],
                                );
                              },
                            ),
                          ),
                          // Text("${product.likes?.length}")
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${product.prodDescription}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ElevatedButton.icon(
          onPressed: () async {
            if (!cart.isProductInCart(product.prodId!)) {
              _showBottomSheet(context, product);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Item is already in the Cart"),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          icon: const Icon(Icons.shopping_cart),
          label: const Text(
            "Add to Cart",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context, ProductModel product) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      int quantity = 1;
      return StatefulBuilder(builder: (context, setState) {
        return SizedBox(
          height: 200,
          child: Column(
            children: [
              const Text('Quantity'),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          quantity--;
                        });
                      },
                      child: const Text('-'),
                    ),
                  ),
                  Text(quantity.toString()),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      child: const Text('+'),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  // Add the product to the cart.
                  // Get the cart provider.
                  final cartProvider =
                      Provider.of<CartProvider>(context, listen: false);

                  // Create a cart item.
                  final cartItem = CartItem(
                    productId: product.prodId ?? "",
                    imageUrl: product.prodImage ?? "",
                    name: product.prodName ?? '',
                    quantity: quantity,
                    price: product.prodPrice ?? 0,
                  );
                  // Add the cart item to the cart.
                  cartProvider.addItem(cartItem);
                  Navigator.pop(context);
                },
                child: const Text('Add to Cart'),
              ),
            ],
          ),
        );
      });
    },
  );
}

void addToFavourite(String? prodId, String userId) async {
  // Reference to the Firestore collection containing user data
  final userCollection = FirebaseFirestore.instance.collection('users');

  // Reference to the specific user's document
  final userDocRef = userCollection.doc(userId);

  // Fetch user's data from Firestore
  DocumentSnapshot userSnapshot = await userDocRef.get();
  Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

  // Get the current list of favorite blogs from the user's data
  List<String> favoriteBlogs =
      List<String>.from(userData['favorite_products'] ?? []);

  // Check if the blogId is already in the favorites
  if (favoriteBlogs.contains(prodId)) {
    // If the blog is already in favorites, remove it
    favoriteBlogs.remove(prodId);

    // Also remove the user's ID from the blog's likes array
    final blogDocRef = firebaseFirestore.collection('products').doc(prodId);
    await blogDocRef.update({
      'likes': FieldValue.arrayRemove([userId]),
    });
  } else {
    // If the blog is not in favorites, add it
    favoriteBlogs.add(prodId!);

    // Also add the user's ID to the blog's likes array
    final blogDocRef =
        FirebaseFirestore.instance.collection('products').doc(prodId);
    await blogDocRef.update({
      'likes': FieldValue.arrayUnion([userId]),
    });
  }

  // Update the user's favorite blogs in Firestore
  await userDocRef.update({'favorite_products': favoriteBlogs});
}
