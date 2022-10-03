import 'package:flutter/material.dart';

import 'utils.dart';

abstract class LinearCustomPainter extends CustomPainter {
  LinearCustomPainter({
    required this.minValue,
    required this.maxValue,
    required this.actualValue,
    required this.ranges,
    required this.divisions,
    required this.title,
    required this.titlePosition,
    required this.pointerIcon,
    required this.decimalPlaces,
    required this.gaugeStrokeWidth,
    required this.rangeStrokeWidth,
    required this.majorTickStrokeWidth,
    required this.minorTickStrokeWidth,
    required this.actualValueTextStyle,
    required this.majorTicksValueTextStyle,
  });

  /// Sets the minimum value of the gauge.
  final double minValue;

  /// Sets the maximum value of the gauge.
  final double maxValue;

  /// Sets the pointer value of the gauge.
  final double actualValue;

  /// Sets the ranges for the gauge.
  final List<Range?> ranges;

  /// Sets the major divisions of the gauges.
  final int divisions;

  /// Sets the title of the gauge.
  final Text title;

  /// Sets the position of the title.
  final TitlePosition titlePosition;

  /// Sets the pointer icon of the gauge.
  final Icon pointerIcon;

  /// Controls how much decimal places will be shown for the [minValue],[maxValue] and [actualValue].
  final int decimalPlaces;

  /// Sets the stroke width of the ranges.
  final double rangeStrokeWidth;

  /// Sets the stroke width of the gauge.
  final double gaugeStrokeWidth;

  /// Sets the stroke width of the majorTicks
  final double majorTickStrokeWidth;

  /// Sets the stroke width of the minorTicks
  final double minorTickStrokeWidth;

  /// Sets the [TextStyle] for the actualValue.
  final TextStyle actualValueTextStyle;

  /// Sets the [TextStyle] for the mjorTicksValue.
  final TextStyle majorTicksValueTextStyle;

  ///find scale lowest value
  double getScaleLowerLimit(Size size) => size.height / kLowerScaleLimit;

  ///find scale highest value
  double getScaleUpperLimit(Size size) => size.height / kUpperScaleLimit;

  /// find the length of the scale
  double getScaleLength(Size size) =>
      getScaleUpperLimit(size) - getScaleLowerLimit(size);

  /// Find the distance between each majorTicks.
  double getScaleInterval(Size size) => getScaleLength(size) / divisions;

  double getActualValuePosition(Size size) {
    final scaleLowerRangeValue = getScaleLowerLimit(size);
    final scaleUpperRangeValue = getScaleUpperLimit(size);

    return scaleLowerRangeValue +
        ((actualValue - minValue) / (maxValue - minValue)) *
            (scaleUpperRangeValue - scaleLowerRangeValue);
  }

  /// Draws the main scale of the Gauge
  void drawGaugeScale(Canvas canvas, Size size) {
    final Offset endPoint = Offset(size.width / 2, getScaleUpperLimit(size));
    final Offset startPoint = Offset(size.width / 2, getScaleLowerLimit(size));
    final gaugeScalePainter = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = gaugeStrokeWidth;

    canvas.drawLine(startPoint, endPoint, gaugeScalePainter);
  }

  void drawMajorTickMarks({
    required Canvas canvas,
    required Size size,
  }) {
    final interval = getScaleInterval(size);

    var majorTickMarkPosition = getScaleLowerLimit(size);

    for (var i = 0; i < (divisions + 1); i++) {
      final Offset majorTickMarksEndPoint =
          Offset(size.width / 1.8, majorTickMarkPosition);

      final Offset majorTickMarksStartPoint =
          Offset(size.width / 2.02, majorTickMarkPosition);

      final majorTickMarksPainter = Paint()
        ..color = Colors.grey.shade300
        ..strokeWidth = majorTickStrokeWidth;

      canvas.drawLine(majorTickMarksStartPoint, majorTickMarksEndPoint,
          majorTickMarksPainter);
      majorTickMarkPosition = majorTickMarkPosition + interval;
    }
  }

  void drawMinorTickMarks({
    required Canvas canvas,
    required Size size,
  }) {
    /// the total length of the scale
    final scaleLength = getScaleLength(size);

    /// the minor division
    /// multiplying the max division by 5 to find the total divisions within the scale
    var minorDivisions = divisions * 5;

    /// finds the distance needed between each [MinorDivisions]
    final interval = scaleLength / minorDivisions;

    var minorTickMarkPosition = size.height / kLowerScaleLimit;

    for (var i = 0; i < (minorDivisions + 1); i++) {
      final Offset minorTickMarksEndPoint =
          Offset(size.width / 1.9, minorTickMarkPosition);

      final Offset minorTickMarksStartPoint =
          Offset(size.width / 2, minorTickMarkPosition);

      final majorTickMarksPainter = Paint()
        ..color = Colors.grey.shade300
        ..strokeWidth = minorTickStrokeWidth;

      canvas.drawLine(minorTickMarksStartPoint, minorTickMarksEndPoint,
          majorTickMarksPainter);
      minorTickMarkPosition = minorTickMarkPosition + interval;
    }
  }

  void drawMajorTicksValue({
    required Canvas canvas,
    required Size size,
  }) {
    /// find the interval of max value
    final valueInterval = (maxValue - minValue) / divisions;

    final ticksInterval = getScaleInterval(size);

    // 8 Is the value required to adjust the tick position
    var majorTickMarkPosition = getScaleLowerLimit(size) - 8;

    for (var i = 0; i <= (divisions); i++) {
      // multiply the interval by the division to find the value at the division.
      var value = (i * valueInterval) + minValue;
      // if (value > minValue) {
      var stringValue = value.toStringAsFixed(decimalPlaces);

      // sets the paint properites of the tick value.
      final majorTickValuePainter = TextPainter(
        textAlign: TextAlign.center,
        text: TextSpan(
            style: majorTicksValueTextStyle.copyWith(), text: stringValue),
        textDirection: TextDirection.ltr,
      )..layout();

      /// Find the position of the ticks
      final Offset majorTickValuePosition =
          Offset(size.width / 1.7, majorTickMarkPosition);

      majorTickValuePainter.paint(canvas, majorTickValuePosition);
      majorTickMarkPosition = majorTickMarkPosition + ticksInterval;
      // }
    }
  }

  /// Draws the main scale of the Gauge
  void drawGaugePointer(Canvas canvas, Size size, Color color) {
    final Offset upperLimitDisplay =
        Offset(size.width / 2, getActualValuePosition(size));
    final Offset lowerLimitDisplay =
        Offset(size.width / 2, getScaleLowerLimit(size));
    final gaugeScalePainter = Paint()
      ..color = color
      ..strokeWidth = gaugeStrokeWidth;

    canvas.drawLine(lowerLimitDisplay, upperLimitDisplay, gaugeScalePainter);
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawGaugeScale(canvas, size);
    drawMajorTickMarks(
      canvas: canvas,
      size: size,
    );
    drawMinorTickMarks(
      canvas: canvas,
      size: size,
    );
    drawMajorTicksValue(
      canvas: canvas,
      size: size,
    );

    drawGaugePointer(canvas, size, Colors.red);
  }
}

abstract class LinearCustomGauge extends StatefulWidget {
  LinearCustomGauge({
    required this.minValue,
    required this.maxValue,
    required this.actualValue,
    required this.ranges,
    required this.divisions,
    required this.size,
    required this.title,
    required this.titlePosition,
    required this.pointerIcon,
    required this.decimalPlaces,
    required this.isAnimate,
    required this.milliseconds,
    required this.gaugeStrokeWidth,
    required this.rangeStrokeWidth,
    required this.majorTickStrokeWidth,
    required this.minorTickStrokeWidth,
    required this.actualValueTextStyle,
    required this.majorTicksValueTextStyle,
  })  : assert(actualValue <= maxValue,
            'actualValue must be less than or equal to maxValue'),
        assert(actualValue >= minValue,
            'actualValue must be greater than or equal to minValue');

  /// Sets the minimum value of the gauge.
  final double minValue;

  /// Sets the maximum value of the gauge.
  final double maxValue;

  /// Sets the pointer value of the gauge.
  final double actualValue;

  /// Sets the ranges for the gauge.
  final List<Range?> ranges;

  /// Sets the major divisions of the gauges.
  final int divisions;

  final double size;

  /// Sets the title of the gauge.
  final Text title;

  /// Sets the position of the title.
  final TitlePosition titlePosition;

  /// Sets the pointer icon of the gauge.
  final Icon pointerIcon;

  /// Controls how much decimal places will be shown for the [minValue],[maxValue] and [actualValue].
  final int decimalPlaces;

  /// Toggle on and off animation.
  final bool isAnimate;

  /// Sets a duration in milliseconds to control the speed of the animation.
  final int milliseconds;

  /// Sets the stroke width of the ranges.
  final double rangeStrokeWidth;

  /// Sets the stroke width of the gauge.
  final double gaugeStrokeWidth;

  ///Sets the stroke width of the major ticks.
  final double majorTickStrokeWidth;

  ///Sets the stroke width of the minor ticks.
  final double minorTickStrokeWidth;

  /// Sets the [TextStyle] for the actualValue.
  final TextStyle actualValueTextStyle;

  /// Sets the [TextStyle] for the mjorTicksValue.
  final TextStyle majorTicksValueTextStyle;
}
