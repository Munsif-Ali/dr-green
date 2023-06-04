import 'package:doctor_green/screen/tabs/disease_detection/detect_disease_screen.dart';
import 'package:flutter/material.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  static const String routeName = "/diseaseDetectionScreen";
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

  final List<Tab> tabs = const <Tab>[
    Tab(text: 'Fruits'),
    Tab(text: 'Vegitables'),
    Tab(text: 'Uncategorized'),
  ];
  late List<Widget> pages;
  @override
  void initState() {
    super.initState();

    pages = [
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
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        DetectDiseaseScreen.routeName,
                        arguments: plant,
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Placeholder(),
                    ),
                  ),
                ),
                Text(plant),
              ],
            ),
          );
        },
      ),
      const Text("Something"),
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        // final TabController tabController = DefaultTabController.of(context)!;
        // tabController.addListener(() {
        //   if (!tabController.indexIsChanging) {
        //     // Your code goes here.
        //     // To get index of current tab use tabController.index
        //   }
        // });
        return Scaffold(
          appBar: AppBar(
            title: const Text("Detect Disease"),
            bottom: TabBar(
              tabs: tabs,
            ),
          ),
          body: TabBarView(
            children: pages,
          ),
        );
      }),
    );
  }
}
