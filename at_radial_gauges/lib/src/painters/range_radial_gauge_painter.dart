import 'dart:math';

import 'package:at_radial_gauges/src/utils/enums.dart';
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
    required this.actualValueTextStyle,
    required this.unit,
    this.titlePosition = TitlePosition.bottom,
    this.title,
    Key? key,
  });

  final double sweepAngle;
  final Color pointerColor;
  final String minValue;
  final String maxValue;
  final double actualValue;
  final TextSpan unit;
  final int decimalPlaces;
  final TitlePosition titlePosition;
  final String? title;

  /// Sets the ranges for the gauge.
  List<Range> ranges;

  /// Sets the [strokeWidth] of the ranges.
  final double strokeWidth;

  /// Sets the [TextStyle] for the actualValue.
  final TextStyle actualValueTextStyle;

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
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - 40) * 0.40;
    // var arcRect = Rect.fromCircle(center: center, radius: radius);
    var arcRect = Rect.fromCenter(
        center: center,
        width: (size.width - strokeWidth - 40),
        height: size.height - strokeWidth - 40);

    // Create range arc first.
    double labelHeight = size.height / 2;

    for (final range in ranges) {
      final rangeArcPaint = Paint()
        ..color = range.backgroundColor
        ..strokeWidth = strokeWidth >= ((size.width - 40) / 2)
            ? (size.width - 40) / 2
            : strokeWidth
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
        maxDegrees: maxDegree,
      );

      // var arc = Path()
      //   ..moveTo(center.dx - 2, center.dy)
      //   ..relativeQuadraticBezierTo(
      //       center.dx, center.dy - 5, center.dx + 2, center.dy);

      // canvas.drawPath(arc, rangeArcPaint);
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
          ..layout();

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
      ..color = pointerColor
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    // The sweepAngle start at 120 degrees from the start of a circle.
    var adjustedSweepAngle =
        sweepAngle + (startAngle - Utils.degreesToRadians(120));

    var needleEndPointOffset = Offset(
      (center.dx) + radius * cos(pi / 1.5 + adjustedSweepAngle),
      (center.dx) + radius * sin(pi / 1.5 + adjustedSweepAngle),
    );

    canvas.drawLine(center, needleEndPointOffset, needlePaint);
    canvas.drawCircle(center, 5, needlePaint);

    // paint scale increments

    final TextPainter valueTextPainter = TextPainter(
        text: TextSpan(
          style: actualValueTextStyle,
          children: [TextSpan(text: unit.text == '' ? '' : ' '), unit],
          text: Utils.sweepAngleRadianToActualValue(
                  sweepAngle: sweepAngle,
                  maxValue: double.parse(maxValue),
                  minValue: double.parse(minValue),
                  maxDegrees: maxDegree)
              .toStringAsFixed(decimalPlaces),
        ),
        textDirection: TextDirection.ltr)
      ..layout();

    var actualValueOffset =
        Offset(center.dx - valueTextPainter.width / 2, center.dy / 0.95);

    // paint value to canvas
    valueTextPainter.paint(canvas, actualValueOffset);

    ///Paint title
    final TextPainter titleTextPainter = TextPainter(
        text: TextSpan(
          style: actualValueTextStyle,
          children: [TextSpan(text: unit.text == '' ? '' : ' '), unit],
          text: title ?? '',
        ),
        textDirection: TextDirection.ltr)
      ..layout();

    var titleValueOffset = titlePosition == TitlePosition.top
        ? Offset((size.width - titleTextPainter.width) / 2, 0)
        : maxDegree > 180
            ? Offset(
                (size.width - titleTextPainter.width) / 2, size.height - 17)
            : Offset((size.width - titleTextPainter.width) / 2,
                (size.height / 2) + 30);

    // paint value to canvas
    titleTextPainter.paint(canvas, titleValueOffset);
  }

  @override
  bool shouldRepaint(RangeRadialGaugePainter oldDelegate) {
    return true;
  }
}
