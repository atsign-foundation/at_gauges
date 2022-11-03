import 'package:flutter/material.dart';

// typedef AtTimeSeriesAxisFormat = String Function(AtTimeSpot spot);

class AtTimeSeriesData {
  final List<AtTimeSpot> timeSpots;
  final double intervalTimeInSeconds;
  final int numOfIntervals;
  final int numOfYLabel;

  final double plotBorderWidth;
  final double chartSeriesWidth;
  final double minY;
  final double maxY;
  final EdgeInsets plotAreaMargin;

  final Text? xAxisTitle;
  final Text? yAxisTitle;

  final TextStyle? yAxisLabelStyle;
  final TextStyle? xAxisLabelStyle;

  final bool drawMinorGridLine;
  final bool drawMajorGridLine;

  final bool drawYAxisTitle;
  final bool drawYAxisLabel;
  final bool drawXAxisTitle;
  final bool drawXAxisLabel;

  final Color chartSeriesColor;
  final Color backgroundColor;
  final Color plotBorderColor;

  final String Function(double)? yLabelFormat;
  final String Function(AtTimeSpot spot, int position)? xLabelFormat;

  AtTimeSeriesData({
    required this.timeSpots,
    required this.intervalTimeInSeconds,
    this.numOfIntervals = 10,
    this.numOfYLabel = 5,
    this.plotBorderWidth = 1,
    this.chartSeriesWidth = 10,
    required this.minY,
    required this.maxY,
    this.plotAreaMargin = const EdgeInsets.only(left: 40, bottom: 40),
    this.xAxisTitle,
    this.yAxisTitle,
    this.yAxisLabelStyle,
    this.xAxisLabelStyle,
    this.drawMinorGridLine = true,
    this.drawMajorGridLine = true,
    this.drawYAxisTitle = true,
    this.drawYAxisLabel = true,
    this.drawXAxisTitle = true,
    this.drawXAxisLabel = true,
    this.chartSeriesColor = const Color(0xFFf4533d),
    this.backgroundColor = Colors.white,
    this.plotBorderColor = Colors.blue,
    this.yLabelFormat,
    this.xLabelFormat,
  });

  void insertSpot({required AtTimeSpot spot}) {
    timeSpots.add(spot);
  }
}

/// Represents a conceptual position in cartesian (axis based) space.
class AtTimeSpot {
  /// [time] determines cartesian (axis based) horizontally position
  /// 0 means most left point of the chart
  ///
  /// [y] determines cartesian (axis based) vertically position
  /// 0 means most bottom point of the chart
  const AtTimeSpot(this.time, this.y);

  final DateTime time;
  final double y;
}
