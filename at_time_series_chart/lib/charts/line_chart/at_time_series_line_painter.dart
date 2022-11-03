import 'dart:ui';

import 'package:at_time_series_chart/utils/at_time_series_painter.dart';
import 'package:flutter/material.dart';

class AtTimeSeriesLinePainter extends AtTimeSeriesPainter {
  AtTimeSeriesLinePainter({
    required super.data,
  });

  @override
  void drawChart(Canvas canvas, Size size) {
    final cPadding = data.chartPadding;
    final chartSize =
        Size(size.width - cPadding.horizontal, size.height - cPadding.vertical);
    final chartOffset = Offset(cPadding.top, cPadding.left);

    ///Draw line
    final positions = <Offset>[];

    for (int i = 0; i < data.numOfIntervals; i++) {
      if (i < data.numOfIntervals - data.timeSpots.length) {
        continue;
      }
      final spot =
          data.timeSpots[i - data.numOfIntervals + data.timeSpots.length];

      final offset = Offset(
        chartSize.width / data.numOfIntervals * i + chartOffset.dy + 20,
        (data.maxY - spot.y) / (data.maxY - data.minY) * chartSize.height +
            chartOffset.dx,
      );

      positions.add(offset);
    }

    final linePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    if (positions.isNotEmpty) {
      final _path = _getPoints(positions, size);

      canvas.drawPath(_path, linePaint);
    }
  }

  Path _getPoints(List<Offset> points, Size size) {
    final _points = points;

    final _path = Path();

    _path.moveTo(_points[0].dx, _points[0].dy);
    _path.lineTo(_points.first.dx, _points.first.dy);

    for (var i = 0; i < _points.length - 1; i++) {
      final _p1 = _points[i % _points.length];
      final _p2 = _points[(i + 1) % _points.length];
      final controlPointX = _p1.dx + ((_p2.dx - _p1.dx) / 2);
      final _mid = (_p1 + _p2) / 2;
      final _firstLerpValue =
          lerpDouble(_mid.dx, controlPointX, 1) ?? size.height;
      final _secondLerpValue = lerpDouble(_mid.dy, _p2.dy, 1) ?? size.height;

      _path.cubicTo(controlPointX, _p1.dy, _firstLerpValue, _secondLerpValue,
          _p2.dx, _p2.dy);

      if (i == _points.length - 2) {
        _path.lineTo(_p2.dx, _p2.dy);
      }
    }

    return _path;
  }

  @override
  void drawMinorGridLine(
    Canvas canvas,
    Size size,
    Paint paint,
    double colChart,
    EdgeInsets chartPadding,
  ) {
    final verticalPath = Path();

    for (int i = 0; i < data.numOfIntervals; i++) {
      verticalPath.moveTo(
        chartPadding.left +
            (size.width - chartPadding.horizontal) / data.numOfIntervals * i +
            colChart,
        size.height - 31,
      );

      verticalPath.lineTo(
        chartPadding.left +
            (size.width - chartPadding.horizontal) / data.numOfIntervals * i +
            colChart,
        0,
      );
    }

    canvas.drawPath(verticalPath, paint);
    super.drawMinorGridLine(canvas, size, paint, colChart, chartPadding);
  }
}
