import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class EngineOperationScreen extends StatefulWidget {
  final Function(bool) onEngineToggle;

  const EngineOperationScreen({super.key, required this.onEngineToggle});

  @override
  _EngineOperationScreenState createState() => _EngineOperationScreenState();
}

class _EngineOperationScreenState extends State<EngineOperationScreen> {
  bool isEngineStarted = false; // Track if engine is started
  final AudioPlayer audioPlayer = AudioPlayer();

  void toggleEngine() {
    setState(() {
      isEngineStarted = !isEngineStarted;
      if (isEngineStarted) {
        audioPlayer.play(AssetSource('sounds/car_start.mp3'));
      } else {
        audioPlayer.stop();
      }
      widget.onEngineToggle(isEngineStarted);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Engine Operation',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: AnimatedContainer(
          height: 200.0,
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isEngineStarted
                ? Colors.red
                : const Color.fromARGB(255, 110, 225, 114),
          ),
          child: TextButton(
            onPressed: toggleEngine,
            child: Text(isEngineStarted ? 'Stop Engine' : 'Start Engine'),
          ),
        ),
      ),
    );
  }
}
