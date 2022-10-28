part of at_time_series_chart;

/// Bar value items have min locked to 0.0 (or [ChartData.axisMin] if defined)
/// Value for bar item can be negative
class BarValue<T> extends ChartItem<T?> {
  /// Simple [BarValue] item just with max value.
  BarValue(
    double max, {
    String? value,
  }) : super(null, null, max);

  /// Bar value, with item `T` and max value
  BarValue.withValue(T value, double max) : super(value, null, max);
}
