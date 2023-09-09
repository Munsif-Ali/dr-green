import 'dart:io' show File;
import 'package:doctor_green/extensions/build_context_extensions.dart';
import 'package:doctor_green/services/network.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DiseaseResultScreen extends StatelessWidget {
  static const String routeName = "/diseaseResultScreen";
  const DiseaseResultScreen({super.key, this.imageFile});
  final XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<Map<String, dynamic>>(
            future: getPrediction(imageFile!),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final results = snapshot.data;
                  return Column(
                    children: [
                      Image.file(
                        File(imageFile!.path),
                        width: double.infinity,
                        height: context.getHeight * 0.6,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        "Results are :",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 10),
                      Text("Detected Disease: ${results?["class"]}"),
                      const SizedBox(height: 10),
                      Text("Probability is ${(results?["probability"] * 100)}")
                      // const Divider(
                      //   indent: 30,
                      //   endIndent: 30,
                      //   thickness: 3,
                      //   color: Colors.black,
                      // ),
                      // Expanded(
                      //   flex: 2,
                      //   child: ListView.builder(
                      //     itemCount: 10,
                      //     itemBuilder: (context, index) {
                      //       return Card(
                      //         child: SizedBox(
                      //           height: 50,
                      //           child: Text("Step#: $index"),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  );
                default:
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
