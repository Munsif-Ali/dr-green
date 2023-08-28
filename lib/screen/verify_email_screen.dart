import 'package:flutter/material.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Verify your email',
              style: TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'You have',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
