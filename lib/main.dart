import 'package:doctor_green/constants/routes_constants.dart';
import 'package:doctor_green/models/blogs_model.dart';
import 'package:doctor_green/screen/authentication/login_screen.dart';
import 'package:doctor_green/screen/authentication/signup_screen.dart';
import 'package:doctor_green/screen/home/home_screen.dart';
import 'package:doctor_green/screen/splash_screen.dart';
import 'package:doctor_green/screen/tabs/blogs/blog_details_screen.dart';
import 'package:doctor_green/screen/tabs/disease_detection/detect_disease_screen.dart';
import 'package:doctor_green/screen/tabs/disease_detection/disease_detection.dart';
import 'package:doctor_green/screen/tabs/disease_detection/disease_result_screen.dart';
import 'package:doctor_green/themes/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        kHomeScreenRoute: (context) => HomeScreen(),
        DiseaseDetectionScreen.routeName: (context) =>
            const DiseaseDetectionScreen(),
        DetectDiseaseScreen.routeName: (context) => DetectDiseaseScreen(),
        DiseaseResultScreen.routeName: (context) => DiseaseResultScreen(
            imageFile: ModalRoute.of(context)!.settings.arguments as XFile),
        BlogDetailsScreen.routeName: (context) => BlogDetailsScreen(
            blog: ModalRoute.of(context)!.settings.arguments as BlogsModel),
      },
    );
  }
}
