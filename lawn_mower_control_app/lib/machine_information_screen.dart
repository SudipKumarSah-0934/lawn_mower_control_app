import 'package:flutter/material.dart';

class MachineInformationScreen extends StatelessWidget {
  const MachineInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Machine Information',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Text('Information will be updated soon'),
      ),
    );
  }
}
