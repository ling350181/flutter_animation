import 'dart:ui';

import 'package:flutter/material.dart';

import 'point_data.dart';

class LinePainter extends CustomPainter {
  final PointData points;

  LinePainter({
    required this.points,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.green
      ..strokeWidth = 2;
    List<Offset> drawPoint = [];
    for (int i = 0; i < points.values.length; i++) {
      drawPoint.add(Offset(3.0 * (i + 1), -points.values[i]));
    }
    canvas.drawPoints(
      PointMode.points,
      drawPoint,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
