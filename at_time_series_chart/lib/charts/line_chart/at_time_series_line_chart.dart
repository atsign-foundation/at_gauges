import 'package:at_time_series_chart/utils/at_time_series_data.dart';
import 'package:flutter/material.dart';

import 'at_time_series_line_painter.dart';

class AtTimeSeriesLineChart extends StatelessWidget {
  final AtTimeSeriesData data;

  const AtTimeSeriesLineChart({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 8),
      constraints: const BoxConstraints(
        minHeight: 200,
      ),
      decoration: BoxDecoration(
        color: data.backgroundColor,
      ),
      child: CustomPaint(
        painter: AtTimeSeriesLinePainter(
          data: data,
        ),
      ),
    );
  }
}
