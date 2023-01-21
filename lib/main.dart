import 'package:doctor_green/screen/authentication/login_screen.dart';
import 'package:doctor_green/screen/authentication/signup_screen.dart';
import 'package:doctor_green/screen/home/home_screen.dart';
import 'package:doctor_green/screen/splash_screen.dart';
import 'package:doctor_green/themes/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Green',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
      routes: {
        SplashScreen.reouteName: (context) => const SplashScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignupScreen.routeName: (context) => const SignupScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
