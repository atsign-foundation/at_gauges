import 'package:flutter/material.dart';

import 'constants.dart';
import 'enums.dart';
import 'radial_helper.dart';

abstract class LinearCustomPainter extends CustomPainter {
  LinearCustomPainter({
    required this.minValue,
    required this.maxValue,
    required this.actualValue,
    required this.decimalPlaces,
    required this.divisions,
    required this.title,
    required this.titlePosition,
    required this.gaugeOrientation,
    required this.pointerColor,
    required this.pointerIcon,
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

  /// Sets the major divisions of the gauges.
  final int divisions;

  /// Sets the title of the gauge.
  final Text title;

  /// Sets the position of the title.
  final TitlePosition titlePosition;

  /// Sets the color of the pointer
  final Color pointerColor;

  /// Sets the pointer icon of the gauge.
  Icon pointerIcon;

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

  /// Sets the [TextStyle] for the majorTicksValue.
  final TextStyle majorTicksValueTextStyle;

  /// Orient the gauge vertically or horizontally.
  final GaugeOrientation gaugeOrientation;

  ///find scale lowest value
  double getScaleLowerLimit(Size size) {
    switch (gaugeOrientation) {
      case GaugeOrientation.horizontal:
        return size.height * kLowerScaleLimitHorizontal;

      case GaugeOrientation.vertical:
        return size.height / kLowerScaleLimitVertical;
    }
  }

  ///find scale highest value
  double getScaleUpperLimit(Size size) {
    switch (gaugeOrientation) {
      case GaugeOrientation.horizontal:
        return size.height * kUpperScaleLimitHorizontal;

      case GaugeOrientation.vertical:
        return size.height / kUpperScaleLimitVertical;
    }
  }

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

  void drawMajorTickMarks({required Canvas canvas, required Size size}) {
    final interval = getScaleInterval(size);

    var majorTickMarkPosition = getScaleLowerLimit(size);

    for (var i = 0; i < (divisions + 1); i++) {
      final Offset majorTickMarksEndPoint =
          Offset((size.width / 1.8) + gaugeStrokeWidth, majorTickMarkPosition);

      final Offset majorTickMarksStartPoint = Offset(
          (size.width / 2.0) - gaugeStrokeWidth / 2, majorTickMarkPosition);

      final majorTickMarksPainter = Paint()
        ..color = Colors.grey.shade300
        ..strokeWidth = majorTickStrokeWidth;

      canvas.drawLine(majorTickMarksStartPoint, majorTickMarksEndPoint,
          majorTickMarksPainter);
      majorTickMarkPosition = majorTickMarkPosition + interval;
    }
  }

  void drawMinorTickMarks({required Canvas canvas, required Size size}) {
    /// the total length of the scale
    final scaleLength = getScaleLength(size);

    /// the minor division
    /// multiplying the max division by 5 to find the total divisions within the scale
    var minorDivisions = divisions * 5;

    /// finds the distance needed between each [MinorDivisions]
    final interval = scaleLength / minorDivisions;

    double minorTickMarkPosition = 0;
    switch (gaugeOrientation) {
      case GaugeOrientation.horizontal:
        minorTickMarkPosition = getScaleLowerLimit(size);
        break;
      case GaugeOrientation.vertical:
        minorTickMarkPosition = size.height / kLowerScaleLimitVertical;
        break;
    }

    for (var i = 0; i < (minorDivisions + 1); i++) {
      final Offset minorTickMarksEndPoint =
          Offset((size.width / 1.9) + gaugeStrokeWidth, minorTickMarkPosition);

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

  void drawMajorTicksValue({required Canvas canvas, required Size size}) {
    /// find the interval of max value
    final valueInterval = (maxValue - minValue) / divisions;

    final ticksInterval = getScaleInterval(size);

    // 8 Is the value required to adjust the tick position
    var majorTickMarkPosition = getScaleLowerLimit(size) - 8;

    for (var i = 0; i <= (divisions); i++) {
      // multiply the interval by the division to find the value at the division.
      var value = (i * valueInterval) + minValue;

      var stringValue = value.toStringAsFixed(decimalPlaces);

      // sets the paint properties of the tick value.
      final majorTickValuePainter = TextPainter(
        textAlign: TextAlign.center,
        text: TextSpan(
            style: majorTicksValueTextStyle.copyWith(), text: stringValue),
        textDirection: TextDirection.ltr,
      )..layout();

      switch (gaugeOrientation) {
        case GaugeOrientation.horizontal:

          /// Find the position of the ticks

          final Offset majorTickValuePosition = Offset(
              (size.width / 1.65) +
                  gaugeStrokeWidth -
                  (majorTickValuePainter.width / 2),
              majorTickMarkPosition);

          final pivot =
              majorTickValuePainter.size.center(majorTickValuePosition);

          canvas.save();
          canvas.translate(pivot.dx, pivot.dy);
          canvas.rotate(RadialHelper.degreesToRadians(-90));
          canvas.translate(-pivot.dx, -pivot.dy);

          majorTickValuePainter.paint(canvas, majorTickValuePosition);
          canvas.restore();
          break;
        case GaugeOrientation.vertical:

          /// Find the position of the ticks
          final Offset majorTickValuePosition = Offset(
              (size.width / 1.7) + gaugeStrokeWidth, majorTickMarkPosition);
          majorTickValuePainter.paint(canvas, majorTickValuePosition);
          break;
      }

      majorTickMarkPosition = majorTickMarkPosition + ticksInterval;
    }
  }

  /// Draws the main scale of the Gauge
  void drawGaugePointer(Canvas canvas, Size size) {
    final halfMajorStrokeWidth = majorTickStrokeWidth / 2;
    final Offset upperLimitDisplay = Offset(
        size.width / 2, getActualValuePosition(size) - halfMajorStrokeWidth);
    final Offset lowerLimitDisplay =
        Offset(size.width / 2, getScaleLowerLimit(size) + halfMajorStrokeWidth);
    final gaugeScalePainter = Paint()
      ..color = pointerColor
      ..strokeWidth = rangeStrokeWidth;

    canvas.drawLine(lowerLimitDisplay, upperLimitDisplay, gaugeScalePainter);
  }

  /// Draws the gauge pointer icon
  void drawPointerIcon(Canvas canvas, Size size) {
    final pointerIconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(pointerIcon.icon!.codePoint),
        style: TextStyle(
          color: pointerIcon.color == null ? Colors.black : pointerIcon.color,
          fontSize: pointerIcon.size == null ? 25 : pointerIcon.size,
          package: pointerIcon.icon!.fontPackage,
          fontFamily: pointerIcon.icon!.fontFamily,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    switch (gaugeOrientation) {
      case GaugeOrientation.horizontal:
        final Offset pointerIconPosition = Offset(
            (size.width / 2.5) - pointerIconPainter.width + 30,
            getActualValuePosition(size) - (pointerIconPainter.height / 2));
        final pivot = pointerIconPainter.size.center(pointerIconPosition);
        canvas.save();
        canvas.translate(pivot.dx, pivot.dy);
        canvas.rotate(RadialHelper.degreesToRadians(-90));
        canvas.translate(-pivot.dx, -pivot.dy);
        pointerIconPainter.paint(canvas, pointerIconPosition);
        canvas.restore();
        break;
      case GaugeOrientation.vertical:
        final Offset pointerIconPosition = Offset(
            (size.width / 2.5) - pointerIconPainter.width + 30,
            getActualValuePosition(size) - (pointerIconPainter.height / 2));
        pointerIconPainter.paint(canvas, pointerIconPosition);
        break;
    }
  }

  /// Draws the gauge actual value
  void drawActualValue(Canvas canvas, Size size) {
    final actualValuePainter = TextPainter(
      text: TextSpan(
        text: actualValue.toStringAsFixed(decimalPlaces),
        style: actualValueTextStyle,
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final Offset actualValuePosition = Offset(
      (size.width / 2.8) -
          actualValuePainter.width +
          (20 - ((pointerIcon.size ?? 24.0) - 20)),
      getActualValuePosition(size) - (actualValuePainter.height / 2),
    );
    switch (gaugeOrientation) {
      case GaugeOrientation.horizontal:
        final pivot = actualValuePainter.size.center(actualValuePosition);
        canvas.save();
        canvas.translate(pivot.dx, pivot.dy);
        canvas.rotate(RadialHelper.degreesToRadians(-90));
        canvas.translate(-pivot.dx, -pivot.dy);
        actualValuePainter.paint(canvas, actualValuePosition);
        canvas.restore();
        break;
      case GaugeOrientation.vertical:
        actualValuePainter.paint(canvas, actualValuePosition);
    }
  }

  void drawTitle(Canvas canvas, Size size) {
    final titlePainter = TextPainter(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: title.data,
          style: title.style == null
              ? TextStyle(color: Colors.black)
              : title.style),
      textDirection: TextDirection.ltr,
    )..layout();

    Offset titlePositionOffset;
    switch (gaugeOrientation) {
      case GaugeOrientation.horizontal:
        if (titlePosition == TitlePosition.top) {
          titlePositionOffset = Offset((size.width / 6), size.height / 2);
        } else {
          titlePositionOffset = Offset((size.width / 1.8), size.height / 2);
        }
        final pivot = titlePainter.size.center(titlePositionOffset);
        canvas.save();
        canvas.translate(pivot.dx, pivot.dy);
        canvas.rotate(RadialHelper.degreesToRadians(-90));
        canvas.translate(-pivot.dx, -pivot.dy);
        titlePainter.paint(canvas, titlePositionOffset);
        canvas.restore();

        break;
      case GaugeOrientation.vertical:
        final halfTextWidth = titlePainter.width / 2;
        double titleHeight;
        if (titlePosition.name == 'top') {
          titleHeight = getScaleUpperLimit(size) - 50;

          /// Subtract this value from half width of canvas to center title.
          final titlePositionOffset =
              Offset(((size.width / 2) - halfTextWidth), titleHeight);
          titlePainter.paint(canvas, titlePositionOffset);
        } else if (titlePosition.name == 'bottom') {
          titleHeight = getScaleLowerLimit(size) + 50;
          final titlePositionOffset =
              Offset(((size.width / 2) - halfTextWidth), titleHeight);
          titlePainter.paint(canvas, titlePositionOffset);
        }
        break;
    }
  }

  void startRotation(Canvas canvas, Size size) {
    switch (gaugeOrientation) {
      case GaugeOrientation.horizontal:
        canvas.save();
        canvas.translate(size.width / 2, size.height / 2);
        canvas.rotate(RadialHelper.degreesToRadians(90));
        canvas.translate(-size.width / 2, -size.height / 2);

        break;

      case GaugeOrientation.vertical:
        break;
    }
  }

  void endRotation(Canvas canvas) {
    switch (gaugeOrientation) {
      case GaugeOrientation.horizontal:
        canvas.restore();
        break;

      case GaugeOrientation.vertical:
        break;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    startRotation(canvas, size);
    drawGaugeScale(canvas, size);
    drawMajorTicksValue(canvas: canvas, size: size);
    drawMajorTickMarks(canvas: canvas, size: size);
    drawMinorTickMarks(canvas: canvas, size: size);

    drawGaugePointer(canvas, size);
    drawPointerIcon(canvas, size);
    drawActualValue(canvas, size);
    drawTitle(canvas, size);
    endRotation(canvas);
  }
}

abstract class LinearCustomGauge extends StatefulWidget {
  LinearCustomGauge({
    required this.minValue,
    required this.maxValue,
    required this.actualValue,
    required this.divisions,
    required this.title,
    required this.titlePosition,
    required this.pointerColor,
    required this.pointerIcon,
    required this.gaugeOrientation,
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

  /// Sets the major divisions of the gauges.
  final int divisions;

  /// Sets the title of the gauge.
  final Text title;

  /// Sets the position of the title.
  final TitlePosition titlePosition;

  /// Sets the color of the pointer.
  final Color pointerColor;

  /// Sets the pointer icon of the gauge.
  final Icon pointerIcon;

  /// Orients the Gauge vertically or horizontally.
  /// Consider reducing the [majorTickStrokeWidth] and the [majorTickStrokeWidth] to 2.
  final GaugeOrientation gaugeOrientation;

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

  /// Sets the [TextStyle] for the majorTicksValue.
  final TextStyle majorTicksValueTextStyle;
}
