import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lawn_mower_control_app/bush_moving_object_painter.dart';
import 'dart:math' as math;

import 'package:lawn_mower_control_app/setting_screen.dart';
import 'package:lawn_mower_control_app/engine_operation_screen.dart';

class MachineOperatingScreen extends StatefulWidget {
  @override
  _MachineOperatingScreenState createState() => _MachineOperatingScreenState();
}

class _MachineOperatingScreenState extends State<MachineOperatingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double carPositionX = 150; // Initial X position for the car
  double carPositionY = 200; // Initial Y position for the car
  double carWidth = 80; // Width of the car
  double carHeight = 50; // Height of the car
  double laneHeight = 200; // Height of the lane (canvas)
  double laneWidth = 300; // Width of the lane (canvas)
  double bladeRotationAngle = 0.0; // Initial angle for blade rotation
  bool isEngineStarted = false; // Track if engine is started
  List<int> directionList = []; // List of direction values for movement
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Duration for one complete rotation
    );

    _controller.addListener(() {
      setState(() {
        bladeRotationAngle =
            _controller.value * 2 * math.pi; // 2pi radians = 360 degrees
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onEngineToggle(bool isStarted) {
    setState(() {
      isEngineStarted = isStarted;
      if (isEngineStarted) {
        // Start engine action
        _controller.repeat(
          period: Duration(milliseconds: 500), // Adjust speed here
        ); // Repeat the animation indefinitely
        startObjectMovement(); // Start moving the object
      } else {
        // Stop engine action
        _controller.stop();
        directionList.clear(); // Clear direction list
      }
    });
  }

  void startObjectMovement() {
    directionList = [
      1,
      128,
      255,
      128,
      1,
      255,
      1,
      128
    ]; // Example direction list (left, straight, right)
    moveCarBasedOnDirections();
  }

  void moveCarBasedOnDirections() {
    if (directionList.isEmpty) {
      // Stop engine if direction list is empty
      onEngineToggle(false);
      return;
    }

    int direction = directionList.removeAt(0); // Get and remove first direction

    switch (direction) {
      case 1:
        moveCarLeft();
        break;
      case 128:
        moveCarForward();
        break;
      case 255:
        moveCarRight();
        break;
      default:
        break;
    }

    // Continue moving based on the remaining directions
    if (isEngineStarted) {
      Future.delayed(Duration(seconds: 1), () {
        moveCarBasedOnDirections();
      });
    }
  }

  void moveCarLeft() {
    setState(() {
      if (carPositionX - 20 >= 0) {
        carPositionX -= 20;
      } else {
        showToast("Reached to left boundary");
      }
    });
  }

  void moveCarRight() {
    setState(() {
      if (carPositionX + 20 + carWidth <= laneWidth) {
        carPositionX += 20;
      } else {
        showToast("Reached to right boundary");
      }
    });
  }

  void moveCarForward() {
    setState(() {
      if (carPositionY - 20 >= 0) {
        carPositionY -= 20;
      } else {
        showToast("Reached to top boundary");
      }
    });
  }

  void moveCarReverse() {
    setState(() {
      if (carPositionY + 20 + carHeight <= laneHeight) {
        carPositionY += 20;
      } else {
        showToast("Reached to bottom boundary");
      }
    });
  }

  void toggleBladeRotation() {
    setState(() {
      if (isEngineStarted) {
        audioPlayer.play(AssetSource('sounds/blade_cutter.mp3'));

        _controller.stop(); // Stop blade rotation animation immediately
        onEngineToggle(false); // Stop the engine if blade rotation is stopped
      } else {
        if (_controller.isAnimating) {
          _controller.stop();
        } else {
          audioPlayer.play(AssetSource('sounds/blade_cutter.mp3'));

          _controller.repeat(
            period: Duration(milliseconds: 500), // Adjust speed here
          );
        }
      }
    });
  }

  void showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Machine Operating',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.build),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EngineOperationScreen(
                        onEngineToggle: onEngineToggle,
                      )));
            },
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.green,
              child: CustomPaint(
                size: Size(laneWidth, laneHeight),
                painter: MainPainter(
                  carPositionX: carPositionX,
                  carPositionY: carPositionY,
                  bladeRotationAngle: bladeRotationAngle,
                  isEngineStarted: isEngineStarted,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isEngineStarted
                    ? Colors.red
                    : const Color.fromARGB(255, 110, 225, 114),
              ),
              child: TextButton(
                onPressed: isEngineStarted ? null : toggleBladeRotation,
                child: Icon(
                  _controller.isAnimating ? Icons.stop : Icons.play_arrow,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: isEngineStarted ? null : moveCarForward,
                  child: Icon(Icons.keyboard_arrow_up),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: isEngineStarted ? null : moveCarLeft,
                      child: Icon(Icons.keyboard_arrow_left),
                    ),
                    SizedBox(width: 80),
                    ElevatedButton(
                      onPressed: isEngineStarted ? null : moveCarRight,
                      child: Icon(Icons.keyboard_arrow_right),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: isEngineStarted ? null : moveCarReverse,
                  child: Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
