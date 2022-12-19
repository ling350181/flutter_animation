import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import 'line_painter.dart';
import 'point_data.dart';

class LineAnim extends StatefulWidget {
  const LineAnim({Key? key}) : super(key: key);

  @override
  _LineAnimState createState() => _LineAnimState();
}

class _LineAnimState extends State<LineAnim> with SingleTickerProviderStateMixin {
  PointData points = PointData();
  late AnimationController _ctrl;

  final Duration animDuration = const Duration(milliseconds: 2000);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: animDuration,
      lowerBound: 0,
      upperBound: 200,
    )..addListener(_collectPoint);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    points.dispose();
    super.dispose();
  }

  void _collectPoint() {
    points.push(_ctrl.value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnim,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) {
          return Container(
            color: Colors.grey[200],
            height: 200,
            width: 600,
            child: CustomPaint(
              painter: LinePainter(
                step: 5,
                span: 5,
                points: points,
              ),
            ),
          );
        },
      ),
    );
  }

  void _startAnim() async {
    _ctrl.reset();
    _ctrl.fling(
      velocity: 10,
      springDescription: SpringDescription.withDampingRatio(
        mass: 1.0,
        stiffness: 500.0,
        ratio: 5.0,
      ),
    );
  }
}
