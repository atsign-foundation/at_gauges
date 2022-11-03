import 'package:at_time_series_chart/utils/at_time_series_data.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart' as intl;

const yMarkCount = 5;
double colChart = 20;
double lineWidth = 0.2;

TextStyle textStyleDefault = const TextStyle(
  color: Colors.black,
  fontSize: 11,
);

class AtTimeSeriesPainter extends CustomPainter {
  final AtTimeSeriesData data;
  late Paint gridLinePaint;

  AtTimeSeriesPainter({
    required this.data,
  }) {
    gridLinePaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final cPadding = data.chartPadding;

    drawPlotBorder(canvas, size);

    ///Draw X axis mark

    var paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;

    if (data.drawMinorGridLine) {
      drawMinorGridLine(canvas, size);
    }

    ///Draw X axis title
    final xAxisTitle = data.xAxisTitle;

    if (data.drawXAxisLabel) {
      drawXAxisTitle(canvas, size);
    }

    ///Draw x axis label
    if (data.numOfIntervals >= data.timeSpots.length) {
      for (int i = data.timeSpots.length; i > 0; i--) {
        final value = data.timeSpots[data.timeSpots.length - i].time;

        final timeSpan = TextSpan(
          text: intl.DateFormat("hh:mm:ss").format(value),
          style: xAxisTitle?.style ?? textStyleDefault,
        );

        TextPainter xAxisTp = TextPainter(
          text: timeSpan,
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
              size.width -
                  cPadding.right -
                  (i - 1) *
                      (size.width - cPadding.horizontal) /
                      data.numOfIntervals -
                  xAxisTp.size.width / 2 +
                  colChart -
                  (size.width - cPadding.horizontal) / data.numOfIntervals,
              size.height - cPadding.bottom + 5,
            ));
      }
    } else {
      for (int i = 0; i < data.numOfIntervals; i++) {
        if (i < data.numOfIntervals - data.timeSpots.length) {
          break;
        }

        final value = data
            .timeSpots[i - data.numOfIntervals + data.timeSpots.length].time;

        final timeSpan = TextSpan(
          text: intl.DateFormat("hh:mm:ss").format(value),
          style: xAxisTitle?.style ?? textStyleDefault,
        );

        TextPainter xAxisTp = TextPainter(
          text: timeSpan,
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
                  xAxisTp.size.width / 2 +
                  colChart,
              size.height - cPadding.bottom + 5,
            ));
      }
    }

    ///Draw y axis mark
    if (data.drawMajorGridLine) {
      drawMajorGridLine(canvas, size);
    }

    canvas.save();

    if (data.drawYAxisTitle) {
      drawYAnnotate(canvas, size);
    }

    drawChart(canvas, size);
  }

  /// Draw plot border
  void drawPlotBorder(Canvas canvas, Size size) {
    final cPadding = data.chartPadding;
    final xPath = Path();
    xPath.moveTo(cPadding.left, cPadding.top);
    xPath.lineTo(cPadding.left, size.height - cPadding.bottom);
    xPath.lineTo(size.width - cPadding.right, size.height - cPadding.bottom);
    xPath.lineTo(size.width - cPadding.right, cPadding.top);
    xPath.lineTo(cPadding.left, cPadding.top);

    final xPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawPath(xPath, xPaint);
  }

  void drawTitle(Canvas canvas, Size size) {}

  void drawChart(Canvas canvas, Size size) {}

  void drawMinorGridLine(
    Canvas canvas,
    Size size,
  ) {}

  void drawMajorGridLine(
    Canvas canvas,
    Size size,
  ) {
    final yPath = Path();
    final cPadding = data.chartPadding;

    for (int i = 1; i < yMarkCount; i++) {
      yPath.moveTo(cPadding.left + lineWidth,
          cPadding.top + (size.height - cPadding.vertical) / yMarkCount * i);
      yPath.lineTo((size.width - cPadding.right),
          cPadding.top + (size.height - cPadding.vertical) / yMarkCount * i);
    }

    canvas.drawPath(yPath, gridLinePaint);
  }

  void drawXAxisTitle(
    Canvas canvas,
    Size size,
  ) {
    final xAxisTitle = data.xAxisTitle;
    final cPadding = data.chartPadding;

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
  }

  void drawYAnnotate(Canvas canvas, Size size) {
    canvas.rotate(pi / 2);

    final cPadding = data.chartPadding;
    final ySpan = TextSpan(
      text: data.yAxisTitle?.data,
      style: data.yAxisTitle?.style ?? textStyleDefault,
    );

    if (data.drawYAxisLabel) {
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
            -(data.yAxisTitle?.style?.fontSize ?? 14) - 5),
      );
    }

    canvas.restore();

    ///Draw y axis label
    for (int i = 0; i <= yMarkCount; i++) {
      final value = data.minY + i * (data.maxY - data.minY) / yMarkCount;
      final span = TextSpan(
        text: value.toStringAsFixed(0),
        style: data.yAxisTitle?.style ?? textStyleDefault,
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
              cPadding.left - yAxisTp.size.width - 3,
              (size.height - cPadding.bottom) -
                  yAxisTp.size.height / 2 -
                  i * (size.height - cPadding.vertical) / yMarkCount));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
