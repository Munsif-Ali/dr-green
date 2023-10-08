import 'package:doctor_green/constants/globals_variables.dart';
import 'package:doctor_green/helpers/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class AllOrderScreen extends StatelessWidget {
  const AllOrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Orders'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchAllOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return circularProgress();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/no_orders.jpeg",
                ),
                const Text("No Orders Found"),
              ],
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final order = snapshot.data?[index];
                print("Order is $order");
                return Card(
                  child: ExpansionTile(
                    title: Text('Order ID: ${order?['order_id']}'),
                    subtitle: Text('Price: ${order?['totalPrice']}'),
                    // trailing: ,
                    children: [
                      for (final item in order?["cartItems"])
                        FutureBuilder<Map<String, dynamic>>(
                          future: getProductById(item["productId"]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return linearProgress();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Text("No Product Found");
                            } else {
                              final product = snapshot.data ?? {};
                              return ListTile(
                                title: Text("${product["prod_name"]}"),
                                subtitle: Text("Quantity: ${item["quantity"]}"),
                                trailing: Text("${product["prod_price"]}"),
                              );
                            }
                          },
                        ),
                      const Divider(
                        thickness: 2,
                      ),
                      Row(
                        children: [
                          const Text("Total Price"),
                          const Spacer(),
                          Text("RS: ${order?["totalPrice"]}"),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text("Deliver"),
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

Future<Map<String, dynamic>> getProductById(itemId) async {
  final ordersCollection = firebaseFirestore.collection('products');
  final querySnapshot =
      await ordersCollection.where('id', isEqualTo: itemId).get();

  final product = querySnapshot.docs.first.data();

  return product;
}

Future<List<Map<String, dynamic>>> fetchAllOrders() async {
  final ordersCollection = firebaseFirestore.collection('orders');
  final querySnapshot = await ordersCollection.get();

  List<Map<String, dynamic>> orders = [];
  for (var doc in querySnapshot.docs) {
    orders.add(doc.data());
  }

  return orders;
}
