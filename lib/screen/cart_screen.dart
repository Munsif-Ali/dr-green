import 'package:doctor_green/constants/globals_variables.dart';
import 'package:doctor_green/providers/cart_provider.dart';
import 'package:doctor_green/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cartProvider.cartItems.isEmpty
          ? Center(child: Image.asset("assets/images/empty_cart.png"))
          : ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartProvider.cartItems[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(cartItem.imageUrl),
                    title: Text(cartItem.name),
                    subtitle: Text('Quantity: ${cartItem.quantity}'),
                    trailing: Text('${cartItem.price} \$'),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: \$${cartProvider.totalPrice}'),
              TextButton(
                onPressed: () async {
                  if (cartProvider.cartItems.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Cart is Empty"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  final user =
                      Provider.of<UserProivder>(context, listen: false).user;
                  final newOrderRef =
                      FirebaseFirestore.instance.collection('orders').doc();
                  showDialog(
                    context: context,
                    builder: (context) {
                      final controller = TextEditingController();
                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: controller,
                                decoration: const InputDecoration(
                                  label: Text("Enter Shipment Address"),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await newOrderRef.set({
                                    "user_id": user.id,
                                    "status": "To Be Delivered",
                                    "order_id": newOrderRef.id,
                                    "shipment_address": controller.text,
                                    'cartItems':
                                        cartProvider.cartItems.map((cartItem) {
                                      return {
                                        'productId': cartItem.productId,
                                        'quantity': cartItem.quantity,
                                      };
                                    }).toList(),
                                    'totalPrice': cartProvider.totalPrice,
                                  }).then((value) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  });
                                  // Clear the cart.
                                  cartProvider.clearCart();
                                },
                                child: const Text("Submit"),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
