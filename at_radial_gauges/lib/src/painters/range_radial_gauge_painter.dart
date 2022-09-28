import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/range.dart';
import '../utils/utils.dart';

class RangeRadialGaugePainter extends CustomPainter {
  RangeRadialGaugePainter({
    required this.sweepAngle,
    required this.pointerColor,
    required this.minValue,
    required this.maxValue,
    required this.actualValue,
    required this.decimalPlaces,
    required this.ranges,
    required this.maxDegree,
    required this.startDegree,
    required this.isLegend,
    required this.strokeWidth,
    this.actualValueTextStyle,
    Key? key,
  });
  final double sweepAngle;
  final Color? pointerColor;
  final String minValue;
  final String maxValue;
  final double actualValue;
  final int decimalPlaces;

  /// Sets the ranges for the gauge.
  List<Range> ranges;

  /// Sets the [strokeWidth] of the ranges.
  final double strokeWidth;

  /// Sets the [TextStyle] for the actualValue.
  final TextStyle? actualValueTextStyle;

  /// Sets the [maxDegree] of the gauge
  final double maxDegree;

  /// Sets the [startDegree] of the gauge
  final double startDegree;

  /// Toggle on and off legend.
  final bool isLegend;

  @override
  void paint(Canvas canvas, Size size) {
    final startAngle = Utils.degreesToRadians(startDegree);
    // final backgroundSweepAngle = Utils.degreesToRadians(maxDegree);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 1 / 2;
    var arcRect = Rect.fromCircle(center: center, radius: radius);

    // Create range arc first.
    double labelHeight = size.height / 2;
    for (final range in ranges) {
      final rangeArcPaint = Paint()
        ..color = range.backgroundColor
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt
        ..style = PaintingStyle.stroke;

      final rangeStartAngle = Utils.actualValueToSweepAngleRadian(
              minValue: 0,
              actualValue: range.lowerLimit,
              maxValue: double.parse(maxValue),
              maxDegrees: maxDegree) +
          startAngle;
      // Because the sweep angle is calculated from 0 the lowerlimit is subtracted from upperlimit to end the sweep angle at the correct degree on the arc.
      final rangeSweepAngle = Utils.actualValueToSweepAngleRadian(
          minValue: 0,
          actualValue: range.upperLimit - range.lowerLimit,
          maxValue: double.parse(maxValue),
          maxDegrees: maxDegree);
      canvas.drawArc(
          arcRect, rangeStartAngle, rangeSweepAngle, false, rangeArcPaint);

      if (range.label != null && isLegend) {
        final TextPainter rangeLabelTextPainter = TextPainter(
            textAlign: TextAlign.start,
            text: TextSpan(
              style: range.legendTextStyle ??
                  const TextStyle(
                    color: Colors.black,
                  ),
              text: range.label,
            ),
            textDirection: TextDirection.ltr)
          ..layout(
            minWidth: size.width / 2,
            maxWidth: size.width / 2,
          );

        final rangeLabelOffset = Offset(size.width / 0.7, labelHeight);
        rangeLabelTextPainter.paint(canvas, rangeLabelOffset);

        final rangeLegendPaint = Paint()
          ..color = range.backgroundColor
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.butt
          ..style = PaintingStyle.stroke;
        // increase line height so label and color aligns
        labelHeight += 10;

        final rangeLineLabelOffsetStart =
            Offset(size.width / 0.72, labelHeight);
        final rangeLineLabelOffsetEnd = Offset(size.width / 0.78, labelHeight);
        if (startDegree >= 180) {
          labelHeight -= 27;
        } else {
          labelHeight += 10;
        }

        canvas.drawLine(rangeLineLabelOffsetStart, rangeLineLabelOffsetEnd,
            rangeLegendPaint);
      }
    }

    // Arc Needle
    var needlePaint = Paint()
      ..color = pointerColor ?? Colors.black
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    const needleLengthConstraints = 15;

    // The sweepAngle start at 120 degrees from the start of a circle.
    var adjustedSweepAngle =
        sweepAngle + (startAngle - Utils.degreesToRadians(120));
    var needleEndPointOffset = Offset(
        (center.dx) +
            (radius - needleLengthConstraints) *
                cos(pi / 1.5 + (adjustedSweepAngle)),
        (center.dx) +
            (radius - needleLengthConstraints) *
                sin(pi / 1.5 + (adjustedSweepAngle)));

    canvas.drawLine(center, needleEndPointOffset, needlePaint);
    canvas.drawCircle(center, 5, needlePaint);

    // paint scale increments

    final TextPainter valueTextPainter = TextPainter(
        text: TextSpan(
          style: actualValueTextStyle ??
              const TextStyle(
                color: Colors.black,
              ),
          text: Utils.sweepAngleRadianToActualValue(
                  sweepAngle: sweepAngle,
                  maxValue: double.parse(maxValue),
                  minValue: double.parse(minValue),
                  maxDegrees: maxDegree)
              .toStringAsFixed(decimalPlaces),
        ),
        textDirection: TextDirection.ltr)
      ..layout();

    var actualValueOffset = Offset(size.width / 2.2, size.height / 1.8);

    // paint value to canvas
    valueTextPainter.paint(canvas, actualValueOffset);
  }

  @override
  bool shouldRepaint(RangeRadialGaugePainter oldDelegate) {
    return true;
  }
}
