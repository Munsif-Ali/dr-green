import 'package:doctor_green/constants/globals_variables.dart';
import 'package:doctor_green/constants/routes_constants.dart';
import 'package:doctor_green/models/blogs_model.dart';
import 'package:doctor_green/providers/blog_provider.dart';
import 'package:doctor_green/providers/cart_provider.dart';
import 'package:doctor_green/providers/user_provider.dart';
import 'package:doctor_green/screen/authentication/login_screen.dart';
import 'package:doctor_green/screen/authentication/signup_screen.dart';
import 'package:doctor_green/screen/home/home_screen.dart';
import 'package:doctor_green/screen/splash_screen.dart';
import 'package:doctor_green/screen/tabs/blogs/blog_details_screen.dart';
import 'package:doctor_green/screen/tabs/blogs/create_blog_screen.dart';
import 'package:doctor_green/screen/tabs/disease_detection/detect_disease_screen.dart';
import 'package:doctor_green/screen/tabs/disease_detection/disease_detection.dart';
import 'package:doctor_green/screen/tabs/disease_detection/disease_result_screen.dart';
import 'package:doctor_green/themes/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProivder()),
        ChangeNotifierProvider(
          create: (context) => BlogProvider(),
        ),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Doctor Green',
        key: navigatorKey,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: const SplashScreen(),
        routes: {
          SplashScreen.reouteName: (context) => const SplashScreen(),
          kLoginScreenRoute: (context) => const LoginScreen(),
          kSignupScreenRoute: (context) => const SignupScreen(),
          kHomeScreenRoute: (context) => HomeScreen(),
          kDiseaseDetectionScreenRoute: (context) =>
              const DiseaseDetectionScreen(),
          kDetectDiseaseScreenRoute: (context) => DetectDiseaseScreen(),
          kDiseaseResultScreenRoute: (context) => DiseaseResultScreen(
              imageFile: ModalRoute.of(context)!.settings.arguments as XFile),
          kBlogDetailsScreenRoute: (context) => BlogDetailsScreen(),
          kCreateBlogScreenRoute: (context) => CreateBlogScren(),
        },
      ),
    );
  }
}
