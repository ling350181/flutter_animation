import 'package:flutter/material.dart';

class FontAnim extends StatefulWidget {
  const FontAnim({Key? key}) : super(key: key);

  @override
  _FontAnimState createState() => _FontAnimState();
}

class _FontAnimState extends State<FontAnim> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  final Duration animDuration = const Duration(milliseconds: 2000);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      value: 0.4,
      vsync: this,
      duration: animDuration,
      upperBound: 1,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnim,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) {
          return Text(
            "Animation",
            style: TextStyle(
              color: Colors.blue,
              fontSize: fontSize,
            ),
          );
        },
      ),
    );
  }

  double get fontSize => 60 * _ctrl.value;

  void _startAnim() {
    _ctrl.repeat(reverse: true);
  }
}
