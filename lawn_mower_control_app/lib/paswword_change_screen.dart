import 'package:flutter/material.dart';

class PasswordChangeScreen extends StatelessWidget {
  const PasswordChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Change',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Text('Information will be updated soon'),
      ),
    );
  }
}
