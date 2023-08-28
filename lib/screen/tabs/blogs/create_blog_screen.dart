import 'package:doctor_green/models/blogs_model.dart';
import 'package:flutter/material.dart';

class CreateBlogScren extends StatelessWidget {
  CreateBlogScren({super.key});
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Blog"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: "Title",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _bodyController,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    // label: Text("Body"),
                    hintText: "Blog Description",
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final String title = _titleController.text;
                    final String body = _bodyController.text;
                    final BlogsModel blog = BlogsModel(
                      title: title,
                      body: body,
                    );
                    createPost(blog);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createPost(BlogsModel blog) async {}
}
