part of at_time_series_chart;

/// Default `ChartItem`
class ChartItem<T> {
  /// Protected constructor for animations
  @protected
  ChartItem(this.value, this.min, this.max);

  /// Minimum chart item value
  final double? min;

  /// Maximum item value
  final double? max;

  /// Items can have value attached to them `T`
  final T? value;

  /// Check if current item is empty
  bool get isEmpty => (max ?? 0) == 0 && (min ?? 0) == 0;

  /// Animate to [endValue] with factor `t`
  ChartItem<T?> animateTo(ChartItem<T?> endValue, double t) {
    return ChartItem<T?>(
      endValue.value,
      lerpDouble(min, endValue.min, t),
      lerpDouble(max, endValue.max, t),
    );
  }

  /// Animate from [startValue] to this with factor `t`
  ChartItem<T?> animateFrom(ChartItem<T?> startValue, double t) {
    return animateTo(startValue, 1 - t);
  }
}
