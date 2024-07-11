import 'package:flutter/material.dart';
import 'package:lawn_mower_control_app/blade_painter.dart';

class MainPainter extends CustomPainter {
  final double carPositionX;
  final double carPositionY;
  final double bladeRotationAngle;
  final bool isEngineStarted;

  MainPainter({
    required this.carPositionX,
    required this.carPositionY,
    required this.bladeRotationAngle,
    required this.isEngineStarted,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw road, lanes, inclines, and car-like object (similar to your existing RoadPainter)

    // Draw car-like object
    final carPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(carPositionX, carPositionY, 80, 50),
      carPaint,
    );

    // Draw rotating blade on top of the car-like object
    canvas.save(); // Save the canvas state before translation

    // Translate to the center of the car (adjust as needed)
    canvas.translate(carPositionX + 40,
        carPositionY - 10); // -10 adjusts the blade position above the car

    // Use BladePainter to draw the rotating blade
    BladePainter bladePainter = BladePainter(rotationAngle: bladeRotationAngle);
    bladePainter.paint(
      canvas,
      Size(4, 4), // Adjust Size as per blade dimensions
    );

    canvas.restore(); // Restore the canvas state after translation
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
