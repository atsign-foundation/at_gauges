import 'package:at_linear_gauges/at_linear_gauges.dart';
import 'package:at_linear_gauges/src/painters/simple_linear_gauge_painter.dart';
import 'package:flutter/material.dart';

class SimpleLinearGauge extends LinearCustomGauge {
  SimpleLinearGauge({
    double minValue = 0,
    required double maxValue,
    required double actualValue,
    List<Range?> ranges = const [],
    int divisions = 10,
    double size = 200,
    Text title = const Text(''),
    TitlePosition titlePosition = TitlePosition.top,
    Icon pointerIcon = const Icon(Icons.arrow_left_outlined),
    int decimalPlaces = 0,
    bool isAnimate = true,
    int milliseconds = kDefaultAnimationDuration,
    double gaugeStrokeWidth = 5.0,
    double rangeStrokeWidth = 20,
    double majorTickStrokeWidth = 5.0,
    double minorTickStrokeWidth = 5.0,
    TextStyle actualValueTextStyle = const TextStyle(color: Colors.black),
    TextStyle majorTickValueTextStyle = const TextStyle(color: Colors.black),
  }) : super(
          minValue: minValue,
          maxValue: maxValue,
          actualValue: actualValue,
          ranges: ranges,
          divisions: divisions,
          size: size,
          title: title,
          titlePosition: titlePosition,
          pointerIcon: pointerIcon,
          decimalPlaces: decimalPlaces,
          isAnimate: isAnimate,
          milliseconds: milliseconds,
          gaugeStrokeWidth: gaugeStrokeWidth,
          rangeStrokeWidth: rangeStrokeWidth,
          majorTickStrokeWidth: majorTickStrokeWidth,
          minorTickStrokeWidth: minorTickStrokeWidth,
          actualValueTextStyle: actualValueTextStyle,
          majorTicksValueTextStyle: majorTickValueTextStyle,
        );

  @override
  State<SimpleLinearGauge> createState() => _SimpleLinearGaugeState();
}

class _SimpleLinearGaugeState extends State<SimpleLinearGauge> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: CustomPaint(
          painter: SimpleLinearGaugePainter(
            maxValue: widget.maxValue,
            minValue: widget.minValue,
            actualValue: widget.actualValue,
            ranges: widget.ranges,
            divisions: widget.divisions,
            title: widget.title,
            titlePosition: widget.titlePosition,
            pointerIcon: widget.pointerIcon,
            decimalPlaces: widget.decimalPlaces,
            rangeStrokeWidth: widget.rangeStrokeWidth,
            gaugeStrokeWidth: widget.gaugeStrokeWidth,
            majorTickStrokeWidth: widget.majorTickStrokeWidth,
            minorTickStrokeWidth: widget.minorTickStrokeWidth,
            actualValueTextStyle: widget.actualValueTextStyle,
            majorTicksValueTextStyle: widget.majorTicksValueTextStyle,
          ),
        ),
      ),
    );
  }
}
