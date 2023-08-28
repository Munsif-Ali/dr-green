import 'package:doctor_green/models/blogs_model.dart';
import 'package:flutter/material.dart';

class BlogDetailsScreen extends StatelessWidget {
  static const String routeName = "/blogDetailsScreen";
  final BlogsModel blog;
  const BlogDetailsScreen({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 0) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(blog.title ?? ""),
        ),
        body: Column(
          children: [
            Hero(
              tag: "${blog.id}",
              child: Image.network(
                blog.imageUrl ?? "https://picsum.photos/id/18/400/400",
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
                            tag: "title${blog.id}",
                            child: Text(
                              "${blog.title}",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          addToFavourite(blog.id);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.favorite_border),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("${blog.body}"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void addToFavourite(String? id) {
    // add this blog to favourite there is likes array in firestore add this user id to that array
  }
}
