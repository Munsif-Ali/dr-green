import 'dart:convert';
import 'dart:ui';

import 'package:doctor_green/constants/globals_variables.dart';
import 'package:doctor_green/constants/routes_constants.dart';
import 'package:doctor_green/providers/user_provider.dart';
import 'package:doctor_green/services/authentication/auth_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String reouteName = "/splashScreen";
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (sharedPreferences != null) {
        final isLoggedIn =
            sharedPreferences?.getString("user") != null ? true : false;
        if (isLoggedIn) {
          final spUser = sharedPreferences?.getString("user");
          print("user $spUser");
          final user = AuthUser.fromJson(jsonDecode(spUser ?? "{}"));
          Provider.of<UserProivder>(context, listen: false).user = user;
        }
        if (isLoggedIn) {
          Navigator.of(context).pushReplacementNamed(kHomeScreenRoute);
          return;
        }
      }
      Navigator.of(context).pushReplacementNamed(kLoginScreenRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            "assets/images/doc.svg",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          // Image.asset('assets/images/logo.png'),

          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),

          Container(
            alignment: Alignment.center,
            // height: double.infinity,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "DOCTOR GREEN",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
