part of at_time_series_chart;

typedef ChartDataRendererFactory<T> = ChartDataRenderer<T> Function(
  ChartData<T?> data,
);

abstract class ChartDataRenderer<T> extends MultiChildRenderObjectWidget {
  ChartDataRenderer({
    Key? key,
    List<Widget> children = const [],
  }) : super(key: key, children: children);
}

abstract class ChartItemRenderer<T> extends RenderBox {
  ChartItemRenderer(this._chartData) : super();

  ChartData<T?> _chartData;

  ChartData<T?> get chartData => _chartData;

  set chartData(ChartData<T?> data) {
    if (_chartData != data) {
      _chartData = data;
      markNeedsPaint();
      markNeedsSemanticsUpdate();
    }
  }
}
