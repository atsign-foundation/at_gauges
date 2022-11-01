import 'package:at_time_series_chart/utils/at_time_series_data.dart';
import 'package:flutter/material.dart';

import 'at_time_series_bar_painter.dart';

class AtTimeSeriesBarChart extends StatelessWidget {
  final AtTimeSeriesData data;

  const AtTimeSeriesBarChart({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 200,
      ),
      decoration: BoxDecoration(
        color: data.backgroundColor,
      ),
      child: CustomPaint(
        painter: AtTimeSeriesBarPainter(data: data),
      ),
    );
  }
}
