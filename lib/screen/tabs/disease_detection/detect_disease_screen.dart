import 'package:doctor_green/screen/tabs/disease_detection/disease_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetectDiseaseScreen extends StatelessWidget {
  static const String routeName = "/detectDiseaseScreen";
  final ImagePicker _picker = ImagePicker();
  DetectDiseaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plant = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(plant),
      ),
      body: Column(
        children: [
          const Card(
            child: ExpansionTile(
              title: Text("Late blight"),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      "Late blight remains the single most important potato disease in GB. It is caused by the oomycete Phytophthora infestans which can infect foliage, stems and tubers and spread prolifically on the wind."),
                ),
              ],
            ),
          ),
          const Card(
            child: ExpansionTile(
              title: Text("Gangrene"),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      "Gangrene is a slow-growing fungal disease of stored potatoes favoured by cool climates.\n\nEarly symptoms are small round, dark depressions that may appear dark grey to brown. These grow to resemble thumb impressions and may overlap, leaving ridges in between."),
                ),
              ],
            ),
          ),
          const Card(
            child: ExpansionTile(
              title: Text("Common scab"),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      "Common scab, caused mainly by Streptomyces scabiei, is an unsightly blemish disease that can affect any crop where tubers experience a dry surface during the critical stage of three to six weeks after tuber initiation."),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton.icon(
                          onPressed: () async {
                            await _picker
                                .pickImage(source: ImageSource.camera)
                                .then((image) {
                              if (image != null) {
                                Navigator.of(context).pushNamed(
                                    DiseaseResultScreen.routeName,
                                    arguments: image);
                              }
                            });
                          },
                          icon: Icon(Icons.camera),
                          label: Text("Take with camera"),
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            await _picker
                                .pickImage(source: ImageSource.gallery)
                                .then((image) {
                              if (image != null) {
                                Navigator.of(context).pushNamed(
                                    DiseaseResultScreen.routeName,
                                    arguments: image);
                              }
                            });
                          },
                          icon: Icon(Icons.browse_gallery),
                          label: Text("Choose from Gallery"),
                        )
                      ],
                    ),
                  );
                },
              );
            },
            child: const Text("Detect Noew"),
          )
        ],
      ),
    );
  }
}
