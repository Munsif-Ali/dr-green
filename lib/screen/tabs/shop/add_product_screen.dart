import 'dart:io';
import 'package:doctor_green/constants/globals_variables.dart';
import 'package:doctor_green/models/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  XFile? _imageFile;
  final TextEditingController _prodNameController = TextEditingController();
  final TextEditingController _prodDescriptionController =
      TextEditingController();
  final TextEditingController _prodPriceController = TextEditingController();
  String? prodCategory;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _prodNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Name of the Product";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Product Name",
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
                    if (image != null) {
                      setState(() {
                        _imageFile = image;
                      });
                    }
                  },
                  label: const Text("Pick Image"),
                  icon: const Icon(Icons.image),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Description of the Product";
                    }
                    return null;
                  },
                  controller: _prodDescriptionController,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    // label: Text("Body"),
                    hintText: "Product Description",
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    hintText: "Product Category",
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                  value: prodCategory,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Select Product Category";
                    }
                    return null;
                  },
                  items: const [
                    DropdownMenuItem(
                      value: "medicine",
                      child: Text("Medicine"),
                    ),
                    DropdownMenuItem(
                      value: "plants",
                      child: Text("Plants"),
                    ),
                  ],
                  onChanged: (value) {
                    prodCategory = value;
                  },
                ),

                const SizedBox(height: 10),
                TextFormField(
                  controller: _prodPriceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Price of the Product";
                    }
                    final int? price = int.tryParse(value);
                    if (price == null || price < 0) {
                      return "Enter valid Price";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Product Price",
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final bool isValid =
                        _formKey.currentState?.validate() ?? false;
                    final product = ProductModel(
                      prodName: _prodNameController.text,
                      prodImage: _imageFile?.path,
                      prodDescription: _prodDescriptionController.text,
                      prodCategory: prodCategory,
                      prodPrice: int.parse(_prodPriceController.text),
                      likes: [],
                    );
                    if (isValid) {
                      await addProduct(product).then((value) {
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      });
                    }
                  },
                  child: const Text("Add Product"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future addProduct(ProductModel product) async {
    // store blog image in firebase storage then get the url of the image and store the blog in firestore
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      fStorage.Reference reference = fStorage.FirebaseStorage.instance
          .ref()
          .child("products")
          .child(fileName);
      fStorage.UploadTask uploadTask =
          reference.putFile(File(_imageFile!.path));
      fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      await taskSnapshot.ref.getDownloadURL().then((url) {
        product.prodImage = url;
      });
      // store blog in firestore

      final doc = firebaseFirestore.collection("products").doc();
      product.prodId = doc.id;
      await doc.set(product.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
