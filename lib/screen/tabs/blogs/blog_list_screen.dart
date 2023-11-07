import 'package:doctor_green/constants/globals_variables.dart';
import 'package:doctor_green/constants/routes_constants.dart';
import 'package:doctor_green/extensions/build_context_extensions.dart';
import 'package:doctor_green/helpers/widgets/progress_bar.dart';
import 'package:doctor_green/models/blogs_model.dart';
import 'package:doctor_green/providers/blog_provider.dart';
import 'package:doctor_green/providers/user_provider.dart';
import 'package:doctor_green/screen/tabs/blogs/blog_details_screen.dart';
import 'package:doctor_green/services/network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogListScreen extends StatelessWidget {
  static const String routeName = "/blogListScreen";
  const BlogListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blogs"),
        // bottom: const PreferredSize(
        //   preferredSize: Size(double.infinity, 30),
        //   child: Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 10),
        //     child: TextField(
        //       decoration: InputDecoration(
        //         isDense: true,
        //       ),
        //     ),
        //   ),
        // ),
      ),
      body: Container(
        // make the picture little opaque
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/app_logo.png",
            ),
          ),
        ),
        child: FutureBuilder<List<BlogsModel>>(
          future: getPosts(),
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
                          final userId =
                              Provider.of<UserProivder>(context, listen: false)
                                  .user
                                  .id;
                          post.isLiked = post.likes?.contains(userId) ?? false;
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
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          if (Provider.of<UserProivder>(context, listen: false).user.isAdmin ??
              false) {
            context.pushNamed(kCreateBlogScreenRoute);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("You are not authorized to add blogs"),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
