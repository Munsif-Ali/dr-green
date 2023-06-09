import 'package:doctor_green/screen/authentication/login_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = "/signupScreen";
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Variables to hold the user's information
  String _name = "";
  String _email = "";
  String _password = "";
  String _confirmPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight -
                  32.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _buildFormField(
                    labelText: "Name",
                    hintText: "Enter your name",
                    onSaved: (value) => _name = value ?? "",
                    validator: (value) {
                      print(value);
                      if (value == null || value.isEmpty) {
                        return "Enter name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  _buildFormField(
                    labelText: "Email",
                    hintText: "Enter your email address",
                    onSaved: (value) => _email = value ?? "",
                  ),
                  const SizedBox(height: 16.0),
                  _buildFormField(
                    labelText: "Password",
                    hintText: "Enter your password",
                    onSaved: (value) => _password = value ?? "",
                  ),
                  const SizedBox(height: 16.0),
                  _buildFormField(
                      labelText: "Confirm Password",
                      hintText: "Confirm your password",
                      onSaved: (value) => _confirmPassword = value ?? "",
                      validator: (value) {
                        if (_password != value) {
                          return 'Password does not match';
                        }
                        return null;
                      }),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('SIGNUP'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Already have account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              LoginScreen.routeName, (route) => false);
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String labelText,
    required String hintText,
    void Function(String?)? onSaved,
    String? Function(String?)? validator,
    bool? isObscure,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
      obscureText: isObscure ?? false,
      validator: validator,
      onSaved: onSaved,
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Perform signup here
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Name: $_name, Email: $_email")));
    }
  }
}
