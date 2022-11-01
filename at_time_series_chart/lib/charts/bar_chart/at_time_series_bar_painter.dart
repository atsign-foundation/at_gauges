import 'package:at_time_series_chart/utils/at_time_series_painter.dart';
import 'package:flutter/material.dart';

class AtTimeSeriesBarPainter extends AtTimeSeriesPainter {
  AtTimeSeriesBarPainter({required super.data});

  @override
  void drawChart(Canvas canvas, Size size) {
    final cPadding = data.chartPadding;
    final chartSize =
        Size(size.width - cPadding.horizontal, size.height - cPadding.vertical);
    final chartOffset = Offset(cPadding.top, cPadding.left);

    ///Draw line
    final linePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    for (int i = 0; i < data.numOfIntervals; i++) {
      if (i < data.numOfIntervals - data.timeSpots.length) {
        continue;
      }
      final spot =
          data.timeSpots[i - data.numOfIntervals + data.timeSpots.length];
      final offset = Offset(
          chartSize.width / data.numOfIntervals * i + chartOffset.dy,
          (data.maxY - spot.y) / (data.maxY - data.minY) * chartSize.height +
              chartOffset.dx);
      canvas.drawLine(
        offset,
        Offset(offset.dx, chartSize.height + cPadding.top),
        linePaint,
      );
    }
  }
}
