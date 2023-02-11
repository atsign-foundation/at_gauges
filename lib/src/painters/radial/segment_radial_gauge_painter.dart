import 'dart:math';

import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class SegmentRadialGaugePainter extends CustomPainter {
  SegmentRadialGaugePainter({
    required this.sweepAngle,
    required this.pointerColor,
    required this.minValue,
    required this.maxValue,
    required this.actualValue,
    required this.needleColor,
    required this.decimalPlaces,
    required this.unit,
    required this.isPointer,
    required this.titleText,
    required this.title2Text,
    required this.segmentStartAngle,
    required this.segmentSweepAngle,
    required this.segmentMainNo,
    required this.segmentSubNo,
    required this.segmentList,
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

  final bool isPointer;
  final String titleText;
  final String title2Text;
  final double segmentStartAngle;
  final double segmentSweepAngle;
  final int segmentMainNo;
  final int segmentSubNo;
  final List<ZoneSegment> segmentList;

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
    final startAngle = RadialHelper.degreesToRadians(segmentStartAngle);
    final backgroundSweepAngle = RadialHelper.degreesToRadians(segmentSweepAngle);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 1 / 2;
    var arcRect = Rect.fromCircle(center: center, radius: radius);

    final zoneRadius = size.width * 1 / 2 - 16.5;
    var zoneArcRect = Rect.fromCircle(center: center, radius: zoneRadius);

    if (segmentList.isNotEmpty) {
      double totalSegmentSize = 0;
      for (var segment in segmentList) {
        totalSegmentSize = totalSegmentSize + segment.size;
      }

      int segmentListLength = segmentList.length;
      for (int i = 0; i < segmentListLength; i++) {
        var segmentSize = segmentList[i].size;
        var segmentColor = segmentList[i].color;

        // Draw Zone Arc
        double previousSegmentAngleSum = 0;

        if (i != 0) {
          for (int j = 0; j < i; j++) {
            previousSegmentAngleSum = previousSegmentAngleSum + segmentList[j].size;
          }
        }

        final zoneStartAngle = RadialHelper.degreesToRadians(
            segmentStartAngle +
            segmentSweepAngle / totalSegmentSize * previousSegmentAngleSum
        );

        final zoneSweepAngle = RadialHelper.degreesToRadians(
            segmentSweepAngle / totalSegmentSize * segmentSize
        );

        final zoneArcPaint = Paint()
          ..color = segmentColor
          ..strokeWidth = 17.5
          ..style = PaintingStyle.stroke;

        canvas.drawArc(
            zoneArcRect, zoneStartAngle, zoneSweepAngle, false, zoneArcPaint);
      }
    }

    // use scale radial gauge pointer style or segment gauge style
    if (isPointer) {
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

    } else {
      // Background Circle
      final backgroundCirclePaint = Paint()
        ..color = Colors.black12
        ..strokeWidth = 10
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(
          center, radius, backgroundCirclePaint);

      // Background Outer Circle
      final outerRadius = size.width * 1 / 2 + 5;

      final backgroundOuterCirclePaint = Paint()
        ..color = Colors.black26
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(
          center, outerRadius, backgroundOuterCirclePaint);
    }

    // Arc Needle
    var needlePaint = Paint()
      ..color = needleColor
      ..strokeWidth = 5
      ..style = PaintingStyle.fill;

    var needleEndPointOffset = Offset(
      (center.dx) + (radius - 15) * cos(startAngle + sweepAngle),
      (center.dy) + (radius - 15) * sin(startAngle + sweepAngle),
    );

    canvas.drawLine(center, needleEndPointOffset, needlePaint);
    canvas.drawCircle(center, 5, needlePaint);

    final halfOfMinMaxValue = (minValue + maxValue) / 2;
    final zeroTextGapMin    = halfOfMinMaxValue / (maxValue - minValue);
    final zeroTextGapHalf   = minValue / (maxValue - minValue);
    final zeroTextGapMax    = maxValue / (maxValue - minValue);

    // Print min / half / max Value Text
    List<double> valueTextList = [minValue, halfOfMinMaxValue, maxValue, 0];
    double valueFontSizeOffset = 0;

    for (var value in valueTextList) {
      var valueLength = value.toStringAsFixed(decimalPlaces).length;
      double valueFontSizeOffsetT = (valueLength / 3).ceil().toDouble();
      if (valueFontSizeOffset < valueFontSizeOffsetT) {
        if (valueFontSizeOffsetT > 2) {
          valueFontSizeOffset = 1.2 * valueFontSizeOffsetT.ceil().toDouble();
        } else {
          valueFontSizeOffset = valueFontSizeOffsetT;
        }
      }
    }

    for (var value in valueTextList) {
      var valueLength = value.toStringAsFixed(decimalPlaces).length;
      bool needValueOffset = false;
      double valueRnd = double.tryParse(value.toStringAsFixed(0)) ?? 0;
      double maxValueOffset = 7.5;
      if (valueRnd != value) {
        needValueOffset = true;
        maxValueOffset = 10;
      } else {
        valueLength = value.toStringAsFixed(0).length;
      }

      final TextPainter valueTextPainter = TextPainter(
        text: TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontSize: 12 - valueFontSizeOffset,
          ),
          text: !needValueOffset ? value.toStringAsFixed(0)
              : value.toStringAsFixed(decimalPlaces),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      // get sweep angle for every value
      var scaleSweepAngle = RadialHelper.actualValueToSweepAngleRadian(
          actualValue: value,
          maxValue: maxValue,
          maxDegrees: segmentSweepAngle,
          minValue: minValue);

      if (value == minValue) {
        var minValueScaleOffset = Offset(
            (center.dx) +
                // (radius - scaleSweepAngle - (45 - valueLength * 3)) *
                (radius - scaleSweepAngle - (35 - valueLength * 3)) *
                    cos(startAngle + scaleSweepAngle),
            (center.dy) +
                (radius - scaleSweepAngle - 45) *
                    sin(startAngle + scaleSweepAngle)
        );

        valueTextPainter.paint(canvas, minValueScaleOffset);
      } else if (value == halfOfMinMaxValue) {
        var halfValueScaleOffset = Offset(
            (center.dx - ((value != 0) ? valueLength : 0) *
                ((valueLength != 3) ? (valueLength / 5).ceil() : 2.5) - 2),
            (center.dy) +
                (radius - scaleSweepAngle - 30) *
                    sin(startAngle + scaleSweepAngle)
        );

        valueTextPainter.paint(canvas, halfValueScaleOffset);
      } else if (value == maxValue) {
        var maxValueScaleOffset = Offset(0, 0);
        if (valueLength >= 5) {
          maxValueScaleOffset = Offset(
              (center.dx) +
                  (radius - scaleSweepAngle -
                      (maxValueOffset + valueLength * 10)) *
                      cos(startAngle + scaleSweepAngle),
              (center.dy) +
                  (radius - scaleSweepAngle - 39.75) *
                      sin(startAngle + scaleSweepAngle));
        } else {
          maxValueScaleOffset = Offset(
              (center.dx) +
                  (radius - scaleSweepAngle -
                      ((maxValueOffset + valueLength) * 5)) *
                      cos(startAngle + scaleSweepAngle),
              (center.dy) +
                  (radius - scaleSweepAngle - 39.75) *
                      sin(startAngle + scaleSweepAngle));
        }

        valueTextPainter.paint(canvas, maxValueScaleOffset);
      } else if (value == 0 && (minValue < 0) && (0 < maxValue)) {
        // Draw 0 if minValue is not 0
        if (
               (zeroTextGapMin.abs()  > 0.08)
            && (zeroTextGapHalf.abs() > 0.08)
            && (zeroTextGapMax.abs()  > 0.08)
        ) {
          var scaleOffset = Offset(0, 0);
          if (value < halfOfMinMaxValue) {
            scaleOffset = Offset(
                (center.dx) +
                    (radius - scaleSweepAngle - 35) *
                        cos(startAngle + scaleSweepAngle),
                (center.dy) +
                    (radius - scaleSweepAngle - 30) *
                        sin(startAngle + scaleSweepAngle));
          } else {
            scaleOffset = Offset(
                (center.dx) +
                    (radius - scaleSweepAngle - 35) *
                        cos(startAngle + scaleSweepAngle),
                (center.dy) +
                    (radius - scaleSweepAngle - 30) *
                        sin(startAngle + scaleSweepAngle));
          }

          valueTextPainter.paint(canvas, scaleOffset);
        }
      }
    }


    final double totalSplitterNo = segmentSubNo * segmentMainNo + 1;
    final valueList = getScale(totalSplitterNo);
    for (int i = 0; i < valueList.length; i++) {
      // get sweep angle for every value
      var scaleSweepAngle = RadialHelper.actualValueToSweepAngleRadian(
          actualValue: valueList[i],
          maxValue: maxValue,
          maxDegrees: segmentSweepAngle,
          minValue: minValue);

      // Main Segment Pointer Line
      double pointerLineRadius1 = size.width * 1 / 2 - 8;
      double pointerLineRadius2 = size.width * 1 / 3 + 7.5;

      var pointerLineOffset1 = Offset(
        (center.dx) + pointerLineRadius1 *
            cos(startAngle + scaleSweepAngle + 0),
        (center.dy) + pointerLineRadius1 *
            sin(startAngle + scaleSweepAngle + 0),
      );

      var pointerLineOffset2 = Offset(
        (center.dx) + pointerLineRadius2 *
            cos(startAngle + scaleSweepAngle + 0),
        (center.dy) + pointerLineRadius2 *
            sin(startAngle + scaleSweepAngle + 0),
      );

      var pointerLinePaint = Paint()
        ..color = Colors.black
        ..strokeWidth = 1
        ..style = PaintingStyle.fill;

      // the main segment number should be multiply of sub segment number
      if ((i % segmentSubNo) == 0) {
        if (isPointer) {
          var strokeCapCirclePaint = Paint()
            ..color = Colors.white
            ..strokeWidth = 5
            ..style = PaintingStyle.fill;

          var strokeCapCircleOffset = Offset(
            (center.dx) + radius * cos(startAngle + scaleSweepAngle + 0),
            (center.dy) + radius * sin(startAngle + scaleSweepAngle + 0),
          );

          var strokeCapCircleRadius = 3.0;

          canvas.drawCircle(
              strokeCapCircleOffset, strokeCapCircleRadius, strokeCapCirclePaint);
        }

      } else {
        // Sub Segment Pointer Line Adjustment
        pointerLineRadius2 = size.width * 1 / 3 + 12.5;

        pointerLinePaint = Paint()
          ..color = Colors.black
          ..strokeWidth = 0.5
          ..style = PaintingStyle.fill;
      }

      canvas.drawLine(
          pointerLineOffset1, pointerLineOffset2, pointerLinePaint);
    }

    final TextPainter actualValueTextPainter = TextPainter(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [TextSpan(text: unit.text == '' ? '' : ' '), unit],
          text: RadialHelper.sweepAngleRadianToActualValue(
              sweepAngle: sweepAngle,
              maxValue: maxValue,
              minValue: minValue,
              maxDegrees: segmentSweepAngle,
          ).toStringAsFixed(decimalPlaces),
        ),
        textDirection: TextDirection.ltr)
      ..layout();

    final actualValueOffset = Offset(
        size.width / 2 - (actualValueTextPainter.width / 2),
        size.height / 1.75
    );

    actualValueTextPainter.paint(canvas, actualValueOffset);

    double titleFont = 11;
    if (titleText.length > 10) {
      titleFont = titleText.length.toDouble() / 2;
    }

    final TextPainter titleTextPainter = TextPainter(
        text: TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontSize: titleFont,
          ),
          text: titleText,
        ),
        textDirection: TextDirection.ltr)
      ..layout();

    final titleOffset = Offset(
        size.width / 2 - (titleTextPainter.width / 2),
        size.height / 1.2
    );

    titleTextPainter.paint(canvas, titleOffset);

    double title2Font = 18;
    if (title2Text.length > 10) {
      title2Font = title2Text.length.toDouble() / 2;
    }

    final TextPainter title2TextPainter = TextPainter(
        text: TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontSize: title2Font,
          ),
          text: title2Text,
        ),
        textDirection: TextDirection.ltr)
      ..layout();

    final title2Offset = Offset(
        size.width / 2 - (title2TextPainter.width / 2),
        size.height / 3.5
    );

    title2TextPainter.paint(canvas, title2Offset);
  }

  @override
  bool shouldRepaint(SegmentRadialGaugePainter oldDelegate) {
    return true;
  }
}