import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/utils.dart';

class SimpleRadialGaugePainter extends CustomPainter {
  SimpleRadialGaugePainter({
    required this.sweepAngle,
    required this.pointerColor,
    Key? key,
  });
  final double sweepAngle;

  final Color pointerColor;

  @override
  void paint(Canvas canvas, Size size) {
    // Circle
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 1 / 2;
    final circlePaint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, circlePaint);

    // Arc
    var arcPaint = Paint()
      ..color = pointerColor
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var arcRect = Rect.fromCircle(center: center, radius: radius);
    final startAngle = Utils.degreesToRadians(-90);

    canvas.drawArc(arcRect, startAngle, sweepAngle, false, arcPaint);

    // Stroke Cap Circle
    var strokeCapCirclePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.fill;

    var strokeCapCircleOffset = Offset(
      (center.dx) +
          radius * cos(pi / 1.5 + sweepAngle + Utils.degreesToRadians(150)),
      (center.dx) +
          radius * sin(pi / 1.5 + sweepAngle + Utils.degreesToRadians(150)),
    );
    var strokeCapCircleRadius = 3.0;

    canvas.drawCircle(
        strokeCapCircleOffset, strokeCapCircleRadius, strokeCapCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
