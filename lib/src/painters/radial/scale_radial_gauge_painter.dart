import 'dart:math';

import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class ScaleRadialGaugePainter extends CustomPainter {
  ScaleRadialGaugePainter({
    required this.sweepAngle,
    required this.pointerColor,
    required this.minValue,
    required this.maxValue,
    required this.actualValue,
    required this.needleColor,
    required this.decimalPlaces,
    required this.unit,
    Key? key,
  });
  final double sweepAngle;
  final Color pointerColor;
  final double minValue;
  final double maxValue;
  final double actualValue;
  final Color needleColor;
  final int decimalPlaces;
  final TextSpan unit;

  List<double> getScale(double divider) {
    List<double> scale = [];
    final double interval = (maxValue - minValue) / (divider - 1);
    for (double i = 0; i < divider; i++) {
      scale.add((minValue + i * interval));
    }
    scale.removeWhere((element) => element < minValue);

    return scale;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final startAngle = RadialHelper.degreesToRadians(120);
    final backgroundSweepAngle = RadialHelper.degreesToRadians(300);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 1 / 2;
    var arcRect = Rect.fromCircle(center: center, radius: radius);

    // Background Arc
    final backgroundArcPaint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
        arcRect, startAngle, backgroundSweepAngle, false, backgroundArcPaint);

    // Arc Pointer
    var pointerArcPaint = Paint()
      ..color = pointerColor
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawArc(arcRect, startAngle, sweepAngle, false, pointerArcPaint);

    // Arc Needle
    var needlePaint = Paint()
      ..color = needleColor
      ..strokeWidth = 5
      ..style = PaintingStyle.fill;

    var needleEndPointOffset = Offset(
      (center.dx) + (radius - 15) * cos(pi / 1.5 + sweepAngle),
      (center.dx) + (radius - 15) * sin(pi / 1.5 + sweepAngle),
    );

    canvas.drawLine(center, needleEndPointOffset, needlePaint);
    canvas.drawCircle(center, 5, needlePaint);

    final halfOfMaxValue = getScale(10).last / 2;
    // paint scale increments
    for (var value in getScale(10)) {
      // print(value);
      //get length of the value
      var valueLength = value.toStringAsFixed(decimalPlaces).length;
      final TextPainter valueTextPainter = TextPainter(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black,
            fontSize: 10,
          ),
          text: value.toStringAsFixed(decimalPlaces),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      // get sweep angle for every value
      var scaleSweepAngle = RadialHelper.actualValueToSweepAngleRadian(
          actualValue: value,
          maxValue: maxValue,
          maxDegrees: 300,
          minValue: minValue);
      // apply sweep angle to arc angle formula
      if (value < halfOfMaxValue) {
        var scaleOffset = Offset(
            (center.dx) +
                (radius - scaleSweepAngle - 15) *
                    cos(pi / 1.5 + scaleSweepAngle),
            (center.dx) +
                (radius - scaleSweepAngle - 15) *
                    sin(pi / 1.5 + scaleSweepAngle));
        valueTextPainter.paint(canvas, scaleOffset);
      } else {
        var scaleOffset = Offset(
            (center.dx) +
                (radius - scaleSweepAngle - (20 + valueLength * 3)) *
                    cos(pi / 1.5 + scaleSweepAngle),
            (center.dx) +
                (radius - scaleSweepAngle - 15) *
                    sin(pi / 1.5 + scaleSweepAngle));
        valueTextPainter.paint(canvas, scaleOffset);
      }

      // adjust formula to be below arc

      // return offset of value

      // paint value to canvas

      // Stroke Cap Circle
      var strokeCapCirclePaint = Paint()
        ..color = Colors.white
        ..strokeWidth = 5
        ..style = PaintingStyle.fill;

      var strokeCapCircleOffset = Offset(
        (center.dx) + radius * cos(pi / 1.5 + scaleSweepAngle + 0),
        (center.dx) + radius * sin(pi / 1.5 + scaleSweepAngle + 0),
      );
      var strokeCapCircleRadius = 3.0;

      canvas.drawCircle(
          strokeCapCircleOffset, strokeCapCircleRadius, strokeCapCirclePaint);
    }

    final TextPainter actualValueTextPainter = TextPainter(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [TextSpan(text: unit.text == '' ? '' : ' '), unit],
          text: RadialHelper.sweepAngleRadianToActualValue(
                  sweepAngle: sweepAngle,
                  maxValue: maxValue,
                  minValue: minValue,
                  maxDegrees: 300)
              .toStringAsFixed(decimalPlaces),
        ),
        textDirection: TextDirection.ltr)
      ..layout();

    final actualValueOffset = Offset(
        size.width / 2 - (actualValueTextPainter.width / 2), size.height / 1.6);

    actualValueTextPainter.paint(canvas, actualValueOffset);
  }

  @override
  bool shouldRepaint(ScaleRadialGaugePainter oldDelegate) {
    return true;
  }
}
