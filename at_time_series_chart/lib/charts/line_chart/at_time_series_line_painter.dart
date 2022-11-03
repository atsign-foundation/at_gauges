import 'dart:ui';

import 'package:at_time_series_chart/utils/at_time_series_painter.dart';

class AtTimeSeriesLinePainter extends AtTimeSeriesPainter {
  AtTimeSeriesLinePainter({
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
    final positions = <Offset>[];

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
            plotAreaOffset.dx,
      );

      positions.add(offset);
    }

    final linePaint = Paint()
      ..color = chartSeriesColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = data.chartSeriesWidth;

    if (positions.isNotEmpty) {
      final path = _getPoints(positions, size);

      canvas.drawPath(path, linePaint);
    }
  }

  Path _getPoints(List<Offset> points, Size size) {
    final path = Path();

    path.moveTo(points[0].dx, points[0].dy);
    path.lineTo(points.first.dx, points.first.dy);

    for (var i = 0; i < points.length - 1; i++) {
      final p1 = points[i % points.length];
      final p2 = points[(i + 1) % points.length];
      final controlPointX = p1.dx + ((p2.dx - p1.dx) / 2);
      final mid = (p1 + p2) / 2;
      final firstLERPValue =
          lerpDouble(mid.dx, controlPointX, 1) ?? size.height;
      final secondLERPValue = lerpDouble(mid.dy, p2.dy, 1) ?? size.height;

      path.cubicTo(
          controlPointX, p1.dy, firstLERPValue, secondLERPValue, p2.dx, p2.dy);

      if (i == points.length - 2) {
        path.lineTo(p2.dx, p2.dy);
      }
    }

    return path;
  }
}
