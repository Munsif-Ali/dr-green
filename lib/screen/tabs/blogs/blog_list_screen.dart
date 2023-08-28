import 'package:doctor_green/constants/routes_constants.dart';
import 'package:doctor_green/extensions/build_context_extensions.dart';
import 'package:doctor_green/models/blogs_model.dart';
import 'package:doctor_green/screen/tabs/blogs/blog_details_screen.dart';
import 'package:doctor_green/services/network.dart';
import 'package:flutter/material.dart';

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
      body: FutureBuilder<List<BlogsModel>>(
        future: getPosts(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final List<BlogsModel> posts = snapshot.data!;
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Card(
                    child: ListTile(
                      leading: Hero(
                        tag: "${post.id}",
                        child: const CircleAvatar(
                          backgroundImage: NetworkImage(
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
                        Navigator.of(context).pushNamed(
                          BlogDetailsScreen.routeName,
                          arguments: post,
                        );
                      },
                    ),
                  );
                },
              );

            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          context.pushNamed(kCreateBlogScreenRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
