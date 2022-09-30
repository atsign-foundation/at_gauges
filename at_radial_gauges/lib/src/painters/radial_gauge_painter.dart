import 'package:flutter/material.dart';

class RadialGaugePainter extends CustomPainter {
  RadialGaugePainter({
    required this.unit,
  });

  /// Sets the unit of the actual value.
  final Text unit;

  void paintActualValueUnit(Canvas canvas, Size size) {}

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
