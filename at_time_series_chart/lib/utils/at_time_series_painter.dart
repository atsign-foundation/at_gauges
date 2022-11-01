import 'package:at_time_series_chart/utils/at_time_series_data.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart' as intl;

class AtTimeSeriesPainter extends CustomPainter {
  final AtTimeSeriesData data;

  AtTimeSeriesPainter({
    required this.data,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cPadding = data.chartPadding;

    ///Draw chart border
    final xPath = Path();
    xPath.moveTo(cPadding.left, cPadding.top);
    xPath.lineTo(cPadding.left, size.height - cPadding.bottom);
    xPath.lineTo(size.width - cPadding.right, size.height - cPadding.bottom);
    xPath.lineTo(size.width - cPadding.right, cPadding.top);
    xPath.lineTo(cPadding.left, cPadding.top);
    final xPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawPath(xPath, xPaint);

    ///Draw X axis mark
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 0.1
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i <= data.numOfIntervals; i++) {
      Offset center = Offset(
        cPadding.left +
            (size.width - cPadding.horizontal) / data.numOfIntervals * i,
        size.height - cPadding.bottom,
      );
      canvas.drawCircle(center, 2, paint);
    }

    ///Draw X axis title
    final xAxisTitle = data.xAxisTitle;
    if (xAxisTitle != null) {
      TextPainter xTp = TextPainter(
        text: TextSpan(text: xAxisTitle.data, style: xAxisTitle.style),
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      xTp.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      xTp.paint(
          canvas,
          Offset((size.width + cPadding.right) / 2 - xTp.size.width / 2,
              size.height - (xAxisTitle.style?.fontSize ?? 14) - 2));
    }

    ///Draw x axis label
    for (int i = 0; i < data.numOfIntervals; i++) {
      if (i < data.numOfIntervals - data.timeSpots.length) {
        break;
      }
      final value = data.timeSpots[i].time;
      final span = TextSpan(
        text: intl.DateFormat("mm:ss").format(value),
        style: xAxisTitle?.style,
      );
      TextPainter xAxisTp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      xAxisTp.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      xAxisTp.paint(
          canvas,
          Offset(
              cPadding.left +
                  i * (size.width - cPadding.horizontal) / data.numOfIntervals -
                  xAxisTp.size.width / 2,
              size.height - cPadding.bottom + 2));
    }
    const yMarkCount = 5;

    ///Draw y axis mark
    for (int i = 0; i <= yMarkCount; i++) {
      var paint = Paint()
        ..color = Colors.black
        ..strokeWidth = 0.1
        ..style = PaintingStyle.fill
        ..strokeCap = StrokeCap.round;
      Offset center = Offset(
        cPadding.left,
        cPadding.top + (size.height - cPadding.vertical) / yMarkCount * i,
      );
      canvas.drawCircle(center, 2, paint);
    }
    canvas.save();
    canvas.rotate(pi / 2);
    final ySpan = TextSpan(
      text: data.yAxisTitle?.data,
      style: data.yAxisTitle?.style,
    );
    TextPainter yTp = TextPainter(
      text: ySpan,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    yTp.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    yTp.paint(
        canvas,
        Offset((size.height - cPadding.vertical) / 2 - yTp.size.width / 2,
            -(data.yAxisTitle?.style?.fontSize ?? 14) - 2));
    canvas.restore();

    ///Draw y axis label
    for (int i = 0; i <= yMarkCount; i++) {
      final value = data.minY + i * (data.maxY - data.minY) / yMarkCount;
      final span = TextSpan(
        text: value.toStringAsFixed(0),
        style: data.yAxisTitle?.style,
      );
      TextPainter yAxisTp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      yAxisTp.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      yAxisTp.paint(
          canvas,
          Offset(
              cPadding.left - yAxisTp.size.width - 2,
              (size.height - cPadding.bottom) -
                  yAxisTp.size.height / 2 -
                  i * (size.height - cPadding.vertical) / yMarkCount));
    }
    drawChart(canvas, size);
  }

  void drawTitle(Canvas canvas, Size size) {

  }

  void drawChart(Canvas canvas, Size size) {

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
