import 'dart:ui';

import 'package:doctor_green/constants/globals_variables.dart';
import 'package:doctor_green/constants/routes_constants.dart';
import 'package:doctor_green/providers/user_provider.dart';
import 'package:doctor_green/screen/all_orders_screen.dart';
import 'package:doctor_green/screen/cart_screen.dart';
import 'package:doctor_green/screen/my_orders_screen.dart';
import 'package:doctor_green/services/authentication/auth_service.dart';
import 'package:doctor_green/services/authentication/auth_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProivder>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Image.network(
              "https://images.pexels.com/photos/3621344/pexels-photo-3621344.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user.photoUrl ??
                      "https://img.freepik.com/premium-vector/man-avatar-profile-picture-vector-illustration_268834-538.jpg"),
                ),
                const SizedBox(height: 10),
                Text(
                  "${user.name}",
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${user.email}",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                // Card(
                //   child: SizedBox(
                //     width: double.infinity,
                //     child: TextButton.icon(
                //       onPressed: () {},
                //       icon: const Icon(Icons.edit),
                //       label: const Text("Edit Profile"),
                //       // color: Colors.purple,
                //     ),
                //   ),
                // ),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const CartScreen();
                          },
                        ));
                      },
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text("My Cart"),
                      // color: Colors.blue,
                    ),
                  ),
                ),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const MyOrderScreen();
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.shop_sharp),
                      label: const Text("My Orders"),
                      // color: Colors.blue,
                    ),
                  ),
                ),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const AllOrderScreen();
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.shop_2),
                      label: const Text("All Orders"),
                      // color: Colors.blue,
                    ),
                  ),
                ),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: () async {
                        await AuthService.firebase().logOut().then((value) {
                          sharedPreferences?.clear();
                          Provider.of<UserProivder>(context, listen: false)
                              .user = AuthUser();
                        });
                        if (context.mounted) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              kLoginScreenRoute, (route) => false);
                        }
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      label: const Text(
                        "Log Out",
                        style: TextStyle(color: Colors.red),
                      ),
                      // color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
