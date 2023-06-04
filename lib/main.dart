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
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   ThemeMode mode = ThemeMode.dark;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(scaffoldBackgroundColor: Colors.white),
//       darkTheme: ThemeData(scaffoldBackgroundColor: Colors.black),
//       themeMode: mode,
//       home: HomePage(
//         changeThemeToDark: () {
//           setState(() {
//             mode = ThemeMode.dark;
//           });
//         },
//         changeThemeToLight: () {
//           setState(() {
//             mode = ThemeMode.light;
//           });
//           print("changes=d");
//         },
//         changeThemeToSystem: () {
//           mode = ThemeMode.system;
//         },
//       ),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage(
//       {Key? key,
//       required this.changeThemeToDark,
//       required this.changeThemeToSystem,
//       required this.changeThemeToLight})
//       : super(key: key);

//   final VoidCallback changeThemeToDark;
//   final VoidCallback changeThemeToSystem;
//   final VoidCallback changeThemeToLight;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton(
//             onPressed: () {
//               changeThemeToDark();
//             },
//             child: const Text('Dark mode')),
//         ElevatedButton(
//             onPressed: () {
//               changeThemeToLight();
//             },
//             child: const Text('Light mode')),
//         ElevatedButton(
//             onPressed: () {
//               changeThemeToSystem();
//             },
//             child: const Text('System mode')),
//       ],
//     ));
//   }
// }
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
        HomeScreen.routeName: (context) => HomeScreen(),
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
