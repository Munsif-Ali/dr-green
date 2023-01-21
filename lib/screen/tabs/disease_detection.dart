import 'package:flutter/material.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  const DiseaseDetectionScreen({super.key});

  @override
  State<DiseaseDetectionScreen> createState() => _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  List<String> plantList = [
    "Potato",
    "Tomato",
    "Pepper",
    "Onion",
    "Garlic",
    "Lady-Finger",
    "Orange",
    "Mangor",
    "Apple",
  ];
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Disease Detection"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: PageView(
              allowImplicitScrolling: true,
              controller: _pageController,
              children: [
                GridView.builder(
                  itemCount: plantList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 3,
                  ),
                  itemBuilder: (context, index) {
                    final plant = plantList[index];
                    return Card(
                      // color: Color.fromARGB(31, 252, 250, 250),
                      elevation: 3,
                      child: Column(
                        children: [
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Placeholder(),
                            ),
                          ),
                          Text(plant),
                        ],
                      ),
                    );
                  },
                ),
                GridView.builder(
                  itemCount: plantList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 3,
                  ),
                  itemBuilder: (context, index) {
                    final plant = plantList[index];
                    return Card(
                      // color: Color.fromARGB(31, 252, 250, 250),
                      elevation: 3,
                      child: Column(
                        children: [
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Placeholder(),
                            ),
                          ),
                          Text(plant),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                    foregroundColor: MaterialStatePropertyAll(Colors.green),
                  ),
                  onPressed: () {
                    _pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Text("Fruits"),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                    foregroundColor: MaterialStatePropertyAll(Colors.green),
                  ),
                  onPressed: () {
                    _pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Text("Vegitables"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
