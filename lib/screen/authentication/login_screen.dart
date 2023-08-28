import 'package:doctor_green/constants/routes_constants.dart';
import 'package:doctor_green/helpers/dialogs/error_dialog.dart';
import 'package:doctor_green/screen/authentication/signup_screen.dart';
import 'package:doctor_green/screen/home/home_screen.dart';
import 'package:doctor_green/services/authentication/auth_service.dart';
import 'package:doctor_green/services/exceptions/auth_exception.dart';
import 'package:doctor_green/services/firebase_authentication.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/loginScreen";
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email address',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onSaved: (value) => _email = value?.trim() ?? "",
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onSaved: (value) => _password = value ?? "",
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('LOGIN'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              SignupScreen.routeName, (route) => false);
                        },
                        child: const Text(
                          "create one",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          kHomeScreenRoute, (route) => false);
                    },
                    child: const Text('Continue as Guest'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await AuthService.firebase()
            .logIn(
          email: _email,
          password: _password,
        )
            .then(
          (_) {
            var user = AuthService.firebase().currentUser;
            if (user != null) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                kHomeScreenRoute,
                (route) => false,
              );
            } else {
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //   verifyEmailRoute,
              //   (route) => false,
              // );
            }
          },
        );
      } on AuthenticationException catch (e) {
        showErrorDialog(
          context,
          e.getMessage,
        );
      }
      if (context.mounted) {}
    }
  }
}
