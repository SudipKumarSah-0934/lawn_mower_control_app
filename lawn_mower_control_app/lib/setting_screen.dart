import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<int> selectedDirections = []; // Initialize the selectedDirections list
  double sliderValue = 128; // Default value at neutral

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Operate Statically",
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'Input for left/right',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DirectionButton(
                        direction: 1,
                        label: "Left",
                        onSelected: (direction) => setState(() {
                          selectedDirections.add(direction);
                        }),
                      ),
                      DirectionButton(
                        direction: 128,
                        label: "Straight",
                        onSelected: (direction) => setState(() {
                          selectedDirections.add(direction);
                        }),
                      ),
                      DirectionButton(
                        direction: 255,
                        label: "Right",
                        onSelected: (direction) => setState(() {
                          selectedDirections.add(direction);
                        }),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, selectedDirections);
                    },
                    child: Text("Add Directions and Back"),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Speed Control',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    value: sliderValue,
                    min: 1,
                    max: 255,
                    divisions: 254,
                    label: getLabelForValue(sliderValue),
                    onChanged: (double value) {
                      setState(() {
                        sliderValue = value;
                      });
                    },
                  ),
                  Text(
                    getLabelForValue(sliderValue),
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getLabelForValue(double value) {
    if (value == 1) {
      return 'Max Forward Speed';
    } else if (value == 128) {
      return 'Neutral';
    } else if (value == 255) {
      return 'Max Reverse Speed';
    } else {
      return 'Speed: ${value.toInt()}';
    }
  }
}

class DirectionButton extends StatelessWidget {
  final int direction;
  final String label;
  final ValueChanged<int> onSelected;

  DirectionButton({
    required this.direction,
    required this.label,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onSelected(direction),
      child: Text(label),
    );
  }
}
