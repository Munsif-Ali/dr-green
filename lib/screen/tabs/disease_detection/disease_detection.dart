import 'package:flutter/material.dart';
import 'package:doctor_green/screen/tabs/disease_detection/detect_disease_screen.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  static const String routeName = "/diseaseDetectionScreen";
  const DiseaseDetectionScreen({super.key});

  @override
  State<DiseaseDetectionScreen> createState() => _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  List<String> plantList = [
    "Potato",
  ];

  final List<Tab> tabs = const <Tab>[
    Tab(text: 'Vegitables'),
    Tab(text: 'Fruits'),
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
      const Center(child: Text("Models are comming soon")),
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
            // actions: [
            //   IconButton(
            //     onPressed: () async {
            //       // http://192.168.1.100:8000/your-api-endpoint
            //       print("clicked");
            //       final response = await https
            //           .get(Uri.parse("http://10.48.25.189:8000/testing"));
            //       print("response is $response");
            //     },
            //     icon: const Icon(
            //       Icons.network_cell,
            //     ),
            //   )
            // ],
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
