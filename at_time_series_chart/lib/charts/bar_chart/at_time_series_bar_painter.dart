import 'package:at_time_series_chart/utils/at_time_series_painter.dart';
import 'package:flutter/material.dart';

class AtTimeSeriesBarPainter extends AtTimeSeriesPainter {
  AtTimeSeriesBarPainter({
    required super.data,
  });

  @override
  void drawChartSeries(Canvas canvas, Size size) {
    final plotAreaMargin = data.plotAreaMargin;
    final plotAreaSize = Size(size.width - plotAreaMargin.horizontal,
        size.height - plotAreaMargin.vertical);
    final plotAreaOffset = Offset(plotAreaMargin.top, plotAreaMargin.left);
    final chartSeriesColor = data.chartSeriesColor;

    ///Draw line
    final linePaint = Paint()
      ..color = chartSeriesColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = data.chartSeriesWidth;

    for (int i = 0; i < data.numOfIntervals; i++) {
      if (i < data.numOfIntervals - data.timeSpots.length) {
        continue;
      }

      final spot =
          data.timeSpots[i - data.numOfIntervals + data.timeSpots.length];

      final offset = Offset(
          plotAreaSize.width / data.numOfIntervals * (i + 0.5) +
              plotAreaOffset.dy,
          (data.maxY - spot.y) / (data.maxY - data.minY) * plotAreaSize.height +
              plotAreaOffset.dx);

      canvas.drawLine(
        offset,
        Offset(
            offset.dx,
            plotAreaSize.height +
                plotAreaMargin.top -
                data.plotBorderWidth / 2),
        linePaint,
      );
    }
  }
}
