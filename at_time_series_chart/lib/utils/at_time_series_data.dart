import 'package:flutter/material.dart';

class AtTimeSeriesData {
  final List<AtTimeSpot> timeSpots;
  final double intervalTimeInSeconds;
  final int numOfIntervals;
  final double minY;
  final double maxY;
  final EdgeInsets chartPadding;
  final Text? xAxisTitle;
  final Text? yAxisTitle;

  /// A background color which is drawn behind th chart.
  Color backgroundColor;

  AtTimeSeriesData({
    required this.timeSpots,
    required this.intervalTimeInSeconds,
    this.numOfIntervals = 10,
    required this.minY,
    required this.maxY,
    this.backgroundColor = Colors.white,
    this.chartPadding = const EdgeInsets.only(left: 40, bottom: 40),
    this.xAxisTitle,
    this.yAxisTitle,
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
