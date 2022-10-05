import 'package:at_linear_gauges/src/utils/utils.dart';
import 'package:flutter/material.dart';

class SimpleLinearGaugePainter extends LinearCustomPainter {
  SimpleLinearGaugePainter({
    required double minValue,
    required double maxValue,
    required double actualValue,
    required List<Range?> ranges,
    required int divisions,
    required Text title,
    required TitlePosition titlePosition,
    required GaugeOrientation gaugeOrientation,
    required Color pointerColor,
    required Icon pointerIcon,
    required int decimalPlaces,
    required double rangeStrokeWidth,
    required double gaugeStrokeWidth,
    required double majorTickStrokeWidth,
    required double minorTickStrokeWidth,
    required TextStyle actualValueTextStyle,
    required TextStyle majorTicksValueTextStyle,
  }) : super(
          minValue: minValue,
          maxValue: maxValue,
          actualValue: actualValue,
          ranges: ranges,
          divisions: divisions,
          title: title,
          titlePosition: titlePosition,
          pointerColor: pointerColor,
          pointerIcon: pointerIcon,
          decimalPlaces: decimalPlaces,
          gaugeStrokeWidth: gaugeStrokeWidth,
          rangeStrokeWidth: rangeStrokeWidth,
          majorTickStrokeWidth: majorTickStrokeWidth,
          minorTickStrokeWidth: minorTickStrokeWidth,
          actualValueTextStyle: actualValueTextStyle,
          majorTicksValueTextStyle: majorTicksValueTextStyle,
          gaugeOrientation: gaugeOrientation,
        );

  @override
  void paint(Canvas canvas, Size size) {
    super.paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
