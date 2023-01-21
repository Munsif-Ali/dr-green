import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DiseaseResultScreen extends StatelessWidget {
  static const String routeName = "/diseaseResultScreen";
  const DiseaseResultScreen({super.key, this.imageFile});
  final XFile? imageFile;

  Future<int> _future() async {
    await Future.delayed(const Duration(seconds: 3));
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: _future(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.file(
                          File(imageFile!.path),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: Text(
                          "Steps to Cure the disease",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      const Divider(
                        indent: 30,
                        endIndent: 30,
                        thickness: 3,
                        color: Colors.black,
                      ),
                      Expanded(
                        flex: 2,
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Container(
                                height: 50,
                                child: Text("Step#: $index"),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                default:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text("Scanning the Image"),
                        SizedBox(height: 10),
                        Text("Please wait!"),
                        SizedBox(height: 10),
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
              }
            }),
      ),
    );
  }
}
