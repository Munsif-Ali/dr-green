import 'package:doctor_green/constants/globals_variables.dart';
import 'package:doctor_green/models/blogs_model.dart';
import 'package:doctor_green/providers/blog_provider.dart';
import 'package:doctor_green/services/network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogDetailsScreen extends StatelessWidget {
  static const String routeName = "/blogDetailsScreen";
  const BlogDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    final userId = sharedPreferences?.getString("id");
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 0) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(blogProvider.blog?.title ?? ""),
        ),
        body: Column(
          children: [
            Hero(
              tag: "${blogProvider.blog?.id}",
              child: Image.network(
                blogProvider.blog?.imageUrl ??
                    "https://picsum.photos/id/18/400/400",
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    height: 250,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Hero(
                            tag: "title${blogProvider.blog?.id}",
                            child: Text(
                              "${blogProvider.blog?.title}",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (userId != null) {
                            blogProvider.likeOrDislike(userId,
                                context: context);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Consumer<BlogProvider>(
                            builder: (context, value, child) {
                              return Column(
                                children: [
                                  Icon(
                                    value.blog?.isLiked ?? false
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                  ),
                                  // Text("${value.blog?.likes?.length}"),
                                ],
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("${blogProvider.blog?.body}"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // void addToFavourite(String? blogId, String userId) async {
  //   // Reference to the Firestore collection containing user data
  //   final userCollection = FirebaseFirestore.instance.collection('users');

  //   // Reference to the specific user's document
  //   final userDocRef = userCollection.doc(userId);

  //   // Fetch user's data from Firestore
  //   DocumentSnapshot userSnapshot = await userDocRef.get();
  //   Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

  //   // Get the current list of favorite blogs from the user's data
  //   List<String> favoriteBlogs =
  //       List<String>.from(userData['favorite_blogs'] ?? []);

  //   // Check if the blogId is already in the favorites
  //   if (favoriteBlogs.contains(blogId)) {
  //     // If the blog is already in favorites, remove it
  //     favoriteBlogs.remove(blogId);

  //     // Also remove the user's ID from the blog's likes array
  //     final blogDocRef =
  //         FirebaseFirestore.instance.collection('blogs').doc(blogId);
  //     await blogDocRef.update({
  //       'likes': FieldValue.arrayRemove([userId]),
  //     });
  //   } else {
  //     // If the blog is not in favorites, add it
  //     favoriteBlogs.add(blogId!);

  //     // Also add the user's ID to the blog's likes array
  //     final blogDocRef =
  //         FirebaseFirestore.instance.collection('blogs').doc(blogId);
  //     await blogDocRef.update({
  //       'likes': FieldValue.arrayUnion([userId]),
  //     });
  //   }

  //   // Update the user's favorite blogs in Firestore
  //   await userDocRef.update({'favorite_blogs': favoriteBlogs});
  // }
}
