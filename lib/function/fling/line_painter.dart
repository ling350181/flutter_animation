import 'dart:ui';

import 'package:flutter/material.dart';

import 'point_data.dart';

class LinePainter extends CustomPainter {
  final double step;
  final double span;
  final PointData points;

  LinePainter({
    this.step = 2,
    this.span = 2,
    required this.points,
  });

  double get partLength => step + span;
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

    //path.lineTo(value, -value);
    //paintDash(canvas, path, paint);
  }

  void paintDash(Canvas canvas, Path path, Paint paint) {
    final PathMetrics pms = path.computeMetrics();
    for (var pm in pms) {
      // 破線組合せセットの数
      final int count = pm.length ~/ partLength;
      for (int i = 0; i < count; i++) {
        // 実線部分を描く
        canvas.drawPath(pm.extractPath(partLength * i, partLength * i + step), paint);
      }
      //paint.color = Colors.red;
      final double tail = pm.length % partLength;
      canvas.drawPath(pm.extractPath(pm.length - tail, pm.length), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
