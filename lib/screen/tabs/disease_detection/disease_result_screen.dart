import 'dart:io' show File;
import 'package:doctor_green/extensions/build_context_extensions.dart';
import 'package:doctor_green/services/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DiseaseResultScreen extends StatefulWidget {
  static const String routeName = "/diseaseResultScreen";
  const DiseaseResultScreen({super.key, this.imageFile});
  final XFile? imageFile;

  @override
  State<DiseaseResultScreen> createState() => _DiseaseResultScreenState();
}

class _DiseaseResultScreenState extends State<DiseaseResultScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    // _animationController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     animateScanAnimation(true);
    //   } else if (status == AnimationStatus.dismissed) {
    //     animateScanAnimation(false);
    //   }
    // });

    super.initState();
  }

  void animateScanAnimation(bool reverse) {
    if (reverse) {
      _animationController.reverse(from: 1.0);
    } else {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: getPrediction(widget.imageFile!),
          builder: (context, snapshot) {
            if (snapshot.hasError) {}
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                _animationController.stop();
                final results = snapshot.data;
                return Column(
                  children: [
                    Image.file(
                      File(widget.imageFile!.path),
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
                  ],
                );
              default:
                // make the scanner animation run infinitely
                _animationController.repeat(reverse: true);
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: CupertinoColors.white),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12))),
                        child: Image.file(
                          File(widget.imageFile!.path),
                          width: double.infinity,
                          height: context.getHeight * 0.6,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ImageScannerAnimation(
                      false,
                      334,
                      _animationController,
                    )
                    //Also this 334 value can be dynamically provided. Here its similar to width of the image container.
                  ],
                );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class ImageScannerAnimation extends AnimatedWidget {
  final bool stopped;
  final double width;

  const ImageScannerAnimation(this.stopped, this.width, this.animation,
      {super.key})
      : super(listenable: animation);

  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    final scorePosition = (animation.value * 440) + 16;

    Color color1 = const Color(0x5532CD32);
    Color color2 = const Color(0x0032CD32);

    if (animation.status == AnimationStatus.reverse) {
      color1 = const Color(0x0032CD32);
      color2 = const Color(0x5532CD32);
    }

    return Positioned(
      bottom: scorePosition,
      left: 16.0,
      child: Opacity(
        opacity: (stopped) ? 0.0 : 1.0,
        child: Container(
          height: 60.0,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.1, 0.9],
              colors: [color1, color2],
            ),
          ),
        ),
      ),
    );
  }
}
