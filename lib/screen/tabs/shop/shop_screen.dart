import 'package:doctor_green/helpers/widgets/progress_bar.dart';
import 'package:doctor_green/models/product_model.dart';
import 'package:doctor_green/providers/product_provider.dart';
import 'package:doctor_green/providers/user_provider.dart';
import 'package:doctor_green/screen/tabs/shop/add_product_screen.dart';
import 'package:doctor_green/screen/tabs/shop/product_details_screen.dart';
import 'package:doctor_green/services/network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProivder>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(Icons.search),
        //   ),
        // ],
      ),
      body: FutureBuilder(
        future: getProducts(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final List<ProductModel> products = snapshot.data ?? [];
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        final userId =
                            Provider.of<UserProivder>(context, listen: false)
                                .user
                                .id;
                        product.isLiked =
                            product.likes?.contains(userId) ?? false;
                        Provider.of<ProductProvider>(context, listen: false)
                            .product = product;
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailsScreen(
                              product: product,
                            );
                          },
                        ));
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              product.prodImage!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${product.prodName}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "RS: ${product.prodPrice}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );

            default:
              return circularProgress();
          }
        },
      ),
      floatingActionButton: user.isAdmin ?? false
          ? FloatingActionButton(
              heroTag: null,
              onPressed: () {
                if (Provider.of<UserProivder>(context, listen: false)
                        .user
                        .isAdmin ??
                    false) {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => const AddProductScreen(),
                    ),
                  )
                      .then((value) {
                    setState(() {});
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("You are not authorized to add products"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Icon(Icons.add),
            )
          : const SizedBox(),
    );
  }
}
