import 'package:flutter/material.dart';

class BladePainter extends CustomPainter {
  final double rotationAngle; // Angle to rotate the blade

  BladePainter({required this.rotationAngle});

  @override
  void paint(Canvas canvas, Size size) {
    Paint bladePaint = Paint()
      ..color = Colors.red // Customize blade color
      ..style = PaintingStyle.fill;

    canvas.save(); // Save the canvas state before rotation

    // Translate to the center of the blade (adjust as needed)
    canvas.translate(size.width / 2, size.height / 2);

    // Rotate the canvas
    canvas.rotate(rotationAngle);

    // Draw the blade shape (example: triangle)
    Path path = Path();
    path.moveTo(0, -20); // Blade tip
    path.lineTo(10, 0); // Blade right corner
    path.lineTo(-10, 20); // Blade left corner
    path.close();

    // Draw the blade on canvas
    canvas.drawPath(path, bladePaint);

    canvas.restore(); // Restore the canvas state after rotation
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
