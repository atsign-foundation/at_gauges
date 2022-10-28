part of at_time_series_chart;

/// Creates a new path that is drawn from the segments of `source`.
/// Passing a `source` that is an empty path will return an empty path.
Path dashPath(
  Path source, {
  required List<double> dashArray,
}) {
  final dest = Path();

  // Get dashed path for this [PathMetric]
  Path pathFromMetrics(PathMetric metric) {
    final path = Path();
    var distance = 0.0;
    var index = 0;

    while (distance < metric.length) {
      final len = dashArray[index % dashArray.length];
      if (index % 2 == 0) {
        path.addPath(metric.extractPath(distance, distance + len), Offset.zero);
      }
      distance += len;
      index++;
    }

    return path;
  }

  source.computeMetrics().forEach((metric) {
    dest.addPath(pathFromMetrics(metric), Offset.zero);
  });

  return dest;
}
