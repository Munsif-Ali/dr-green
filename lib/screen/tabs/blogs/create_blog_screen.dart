import 'dart:io';

import 'package:doctor_green/constants/globals_variables.dart';
import 'package:doctor_green/models/blogs_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

class CreateBlogScren extends StatefulWidget {
  CreateBlogScren({super.key});

  @override
  State<CreateBlogScren> createState() => _CreateBlogScrenState();
}

class _CreateBlogScrenState extends State<CreateBlogScren> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _bodyController = TextEditingController();

  XFile? _imageFile;

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
            child: SingleChildScrollView(
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
                  //write code to pick image for blog
                  _imageFile == null
                      ? const Text("No image selected")
                      : Image.file(
                          File(_imageFile!.path),
                          height: 200,
                          width: 200,
                        ),
                  OutlinedButton.icon(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      setState(() {
                        _imageFile = image;
                      });
                    },
                    label: const Text("Pick Image"),
                    icon: const Icon(Icons.image),
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
                      final user = firebaseAuth.currentUser;
                      final BlogsModel blog = BlogsModel(
                        title: title,
                        body: body,
                        imageUrl: _imageFile!.path,
                        userId: user?.uid,
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
      ),
    );
  }

  void createPost(BlogsModel blog) async {
    // store blog image in firebase storage then get the url of the image and store the blog in firestore

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    fStorage.Reference reference =
        fStorage.FirebaseStorage.instance.ref().child("blogs").child(fileName);
    fStorage.UploadTask uploadTask = reference.putFile(File(_imageFile!.path));
    fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    await taskSnapshot.ref.getDownloadURL().then((url) {
      blog.imageUrl = url;
    });
    // store blog in firestore

    final doc = firebaseFirestore.collection("blogs").doc();
    blog.id = doc.id;
    await doc.set(blog.toJson());
  }
}
