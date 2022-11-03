import 'package:at_time_series_chart/utils/at_time_series_data.dart';
import 'package:flutter/material.dart';
import 'dart:math';

const double _gridLineWidth = 0.2;

const TextStyle _defaultTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 14,
);

class AtTimeSeriesPainter extends CustomPainter {
  final AtTimeSeriesData data;
  late Paint gridLinePaint;

  AtTimeSeriesPainter({
    required this.data,
  }) {
    gridLinePaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = _gridLineWidth
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //Draw border
    _drawPlotBorder(canvas, size);
    //Draw minor grid line
    if (data.drawMinorGridLine) {
      _drawMinorGridLine(canvas, size);
    }
    //Draw major grid line
    if (data.drawMajorGridLine) {
      _drawMajorGridLine(canvas, size);
    }
    //Draw chart series
    drawChartSeries(canvas, size);
    //Draw y axis title
    if (data.drawYAxisTitle) {
      _drawYAxisTitle(canvas, size);
    }
    //Draw x axis title
    if (data.drawXAxisTitle) {
      _drawXAxisTitle(canvas, size);
    }
    //Draw y axis label
    if (data.drawYAxisLabel) {
      _drawYAxisLabel(canvas, size);
    }
    //Draw x axis label
    if (data.drawXAxisLabel) {
      _drawXAxisLabel(canvas, size);
    }
  }

  /// Draw plot border
  void _drawPlotBorder(Canvas canvas, Size size) {
    final cPadding = data.plotAreaMargin;
    final xPath = Path();
    xPath.moveTo(cPadding.left, cPadding.top);
    xPath.lineTo(cPadding.left, size.height - cPadding.bottom);
    xPath.lineTo(size.width - cPadding.right, size.height - cPadding.bottom);
    xPath.lineTo(size.width - cPadding.right, cPadding.top);
    xPath.lineTo(cPadding.left, cPadding.top);

    final xPaint = Paint()
      ..color = data.plotBorderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = data.plotBorderWidth;

    canvas.drawPath(xPath, xPaint);
  }

  void drawChartSeries(Canvas canvas, Size size) {}

  void _drawMinorGridLine(Canvas canvas, Size size) {
    final plotAreaMargin = data.plotAreaMargin;
    final plotAreaSize = Size(size.width - plotAreaMargin.horizontal,
        size.height - plotAreaMargin.vertical);
    final plotAreaOffset = Offset(plotAreaMargin.top, plotAreaMargin.left);
    final verticalPath = Path();

    for (int i = 0; i < data.numOfIntervals; i++) {
      verticalPath.moveTo(
        plotAreaSize.width / data.numOfIntervals * (i + 0.5) +
            plotAreaOffset.dy,
        size.height - plotAreaMargin.bottom - data.plotBorderWidth,
      );

      verticalPath.lineTo(
        plotAreaSize.width / data.numOfIntervals * (i + 0.5) +
            plotAreaOffset.dy,
        0,
      );
    }
    canvas.drawPath(verticalPath, gridLinePaint);
  }

  void _drawMajorGridLine(Canvas canvas, Size size) {
    final yPath = Path();
    final cPadding = data.plotAreaMargin;

    for (int i = 1; i < data.numOfYLabel; i++) {
      yPath.moveTo(
          cPadding.left + _gridLineWidth,
          cPadding.top +
              (size.height - cPadding.vertical) / data.numOfYLabel * i);
      yPath.lineTo(
          (size.width - cPadding.right),
          cPadding.top +
              (size.height - cPadding.vertical) / data.numOfYLabel * i);
    }

    canvas.drawPath(yPath, gridLinePaint);
  }

  void _drawYAxisTitle(Canvas canvas, Size size) {
    canvas.save();
    canvas.rotate(pi / 2);
    final cPadding = data.plotAreaMargin;
    final ySpan = TextSpan(
      text: data.yAxisTitle?.data,
      style: data.yAxisTitle?.style ?? _defaultTextStyle,
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
  }

  void _drawXAxisTitle(Canvas canvas, Size size) {
    final xAxisTitle = data.xAxisTitle;
    final cPadding = data.plotAreaMargin;

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

  void _drawYAxisLabel(Canvas canvas, Size size) {
    final plotAreaMargin = data.plotAreaMargin;

    ///Draw y axis label
    for (int i = 0; i <= data.numOfYLabel; i++) {
      final value = data.minY + i * (data.maxY - data.minY) / data.numOfYLabel;
      final span = TextSpan(
        text: data.yLabelFormat?.call(value) ?? value.toStringAsFixed(0),
        style: data.yAxisLabelStyle ?? _defaultTextStyle,
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
              plotAreaMargin.left - yAxisTp.size.width - 3,
              (size.height - plotAreaMargin.bottom) -
                  yAxisTp.size.height / 2 -
                  i *
                      (size.height - plotAreaMargin.vertical) /
                      data.numOfYLabel));
    }
  }

  void _drawXAxisLabel(Canvas canvas, Size size) {
    final plotAreaMargin = data.plotAreaMargin;
    final plotAreaSize = Size(size.width - plotAreaMargin.horizontal,
        size.height - plotAreaMargin.vertical);
    final plotAreaOffset = Offset(plotAreaMargin.top, plotAreaMargin.left);

    ///Draw x axis label
    for (int i = 0; i < data.numOfIntervals; i++) {
      if (i < data.numOfIntervals - data.timeSpots.length) {
        continue;
      }
      final position = i - data.numOfIntervals + data.timeSpots.length;
      final value = data.timeSpots[position];

      final timeSpan = TextSpan(
        text: data.xLabelFormat?.call(value, position) ??
            "${value.time.hour}:${value.time.minute}:${value.time.second}",
        style: data.xAxisLabelStyle ?? _defaultTextStyle,
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
          plotAreaSize.width / data.numOfIntervals * (i + 0.5) +
              plotAreaOffset.dy -
              xAxisTp.size.width / 2,
          size.height - plotAreaMargin.bottom + 5,
        ),
      );
    }
    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
