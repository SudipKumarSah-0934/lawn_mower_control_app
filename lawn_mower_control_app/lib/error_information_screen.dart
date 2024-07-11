import 'package:flutter/material.dart';

class ErrorInformationScreen extends StatelessWidget {
  const ErrorInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error Information',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Text('Information will be updated soon'),
      ),
    );
  }
}
