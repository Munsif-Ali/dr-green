import 'package:doctor_green/screen/tabs/blog_list_screen.dart';
import 'package:doctor_green/screen/tabs/disease_detection/disease_detection.dart';
import 'package:doctor_green/screen/tabs/favorite_screen.dart';
import 'package:doctor_green/screen/tabs/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import '../tabs/shop/shop_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/homeScreen";
  HomeScreen({super.key, this.lat = 0, this.long = 0});

  double lat;
  double long;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2;
  static const List<Widget> _widgetOptions = <Widget>[
    BlogListScreen(),
    // Text(
    //   'Index 1: Favorite',
    //   style: optionStyle,
    // ),
    FavoriteScreen(),
    DiseaseDetectionScreen(),
    ShopScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.green,
        notchMargin: 5,
        elevation: 5,
        child: SizedBox(
          height: 50.0,
          child: Row(
            // direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: const Icon(Icons.book),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: const Icon(Icons.favorite),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                ),
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: const Icon(Icons.shopping_bag),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 4;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: MediaQuery.of(context).viewInsets.bottom == 0 ? 56 : 0,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              _selectedIndex = 2;
            });
          },
          child: const Icon(
            Icons.local_hospital,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
