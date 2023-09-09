import 'package:doctor_green/constants/globals_variables.dart';
import 'package:doctor_green/helpers/widgets/progress_bar.dart';
import 'package:doctor_green/models/blogs_model.dart';
import 'package:doctor_green/models/product_model.dart';
import 'package:doctor_green/providers/blog_provider.dart';
import 'package:doctor_green/providers/user_provider.dart';
import 'package:doctor_green/screen/tabs/blogs/blog_details_screen.dart';
import 'package:doctor_green/screen/tabs/shop/product_details_screen.dart';
import 'package:doctor_green/services/network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.library_books),
              text: "Blogs",
            ),
            Tab(
              icon: Icon(Icons.shopping_cart),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          FutureBuilder<List<BlogsModel>>(
            future: getFavoritePosts(sharedPreferences?.getString("id") ?? ""),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final List<BlogsModel> posts = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Card(
                        child: ListTile(
                          leading: Hero(
                            tag: "${post.id}",
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                post.imageUrl ??
                                    "https://picsum.photos/id/18/100/100",
                              ),
                            ),
                          ),
                          title: Hero(
                            tag: "title${post.id}",
                            child: Text(
                              post.title ?? "",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          subtitle: Text(
                            post.body ?? "",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            final userId = Provider.of<UserProivder>(context,
                                    listen: false)
                                .user
                                .id;
                            post.isLiked =
                                post.likes?.contains(userId) ?? false;
                            Provider.of<BlogProvider>(context, listen: false)
                                .blog = post;
                            Navigator.of(context).pushNamed(
                              BlogDetailsScreen.routeName,
                            );
                          },
                        ),
                      );
                    },
                  );

                default:
                  return circularProgress();
              }
            },
          ),
          FutureBuilder<List<ProductModel>>(
            future:
                getFavoriteProducts(sharedPreferences?.getString("id") ?? ""),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final List<ProductModel> products = snapshot.data ?? [];
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                          ));
                    },
                  );

                default:
                  return circularProgress();
              }
            },
          ),
        ],
      ),
    );
  }
}
