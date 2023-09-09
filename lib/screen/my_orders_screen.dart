import 'package:doctor_green/constants/globals_variables.dart';
import 'package:doctor_green/helpers/widgets/progress_bar.dart';
import 'package:doctor_green/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProivder>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchOrders(user.id ?? ""),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return circularProgress();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No orders available.');
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final order = snapshot.data?[index];
                return Card(
                  child: ListTile(
                    title: Text('Order ID: ${order?['order_id']}'),
                    subtitle: Text('Status: ${order?['status']}'),
                    trailing: Text("RS: ${order?["totalPrice"]}"),
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

Future<List<Map<String, dynamic>>> fetchOrders(String userId) async {
  final ordersCollection = firebaseFirestore.collection('orders');
  final querySnapshot =
      await ordersCollection.where('user_id', isEqualTo: userId).get();

  List<Map<String, dynamic>> orders = [];
  for (var doc in querySnapshot.docs) {
    orders.add(doc.data());
  }

  return orders;
}
