import 'package:flutter/material.dart';

import '../painters/radial/range_radial_gauge_painter.dart';
import '../utils/constants.dart';
import '../utils/enums.dart';
import '../utils/radial_helper.dart';
import '../utils/range.dart';

class RangeRadialGauge extends StatefulWidget {
  /// Creates a Range Pointer Gauge.
  ///
  /// The [minValue], [maxValue] and [ranges] must not be null.
  const RangeRadialGauge({
    this.minValue = 0,
    required this.maxValue,
    required this.actualValue,
    required this.ranges,
    this.unit = const TextSpan(text: ''),
    this.size = 200,
    this.title,
    this.titlePosition = TitlePosition.top,
    this.pointerColor = Colors.black,
    this.decimalPlaces = 0,
    this.isAnimate = true,
    this.animationDuration = kDefaultAnimationDuration,
    this.rangeStrokeWidth = 70,
    this.actualValueTextStyle = const TextStyle(
      color: Colors.black,
    ),
    this.maxDegree = kDefaultRangeGaugeMaxDegree,
    this.startDegree = kDefaultRangeGaugeStartDegree,
    this.isLegend = false,
    Key? key,
  })  : assert(actualValue <= maxValue,
            'actualValue must be less than or equal to maxValue'),
        assert(startDegree <= 360, 'startDegree must be less than 360'),
        assert(actualValue >= minValue,
            'actualValue must be greater than or equal to minValue'),
        super(key: key);

  /// Sets the minimum value of the gauge.
  final double minValue;

  /// Sets the maximum value of the gauge.
  final double maxValue;

  /// Sets the pointer value of the gauge.
  final double actualValue;

  final TextSpan unit;

  /// Sets the ranges for the gauge.
  final List<Range> ranges;

  /// Sets the height and width of the gauge.
  ///
  /// If the parent widget has unconstrained height like a [ListView], wrap the gauge in a [SizedBox] to better control it's size.
  final double size;

  /// Sets the title of the gauge.
  final Text? title;

  /// Sets the position of the title.
  final TitlePosition titlePosition;

  /// Sets the pointer color of the gauge.
  final Color pointerColor;

  /// Controls how much decimal places will be shown for the [minValue],[maxValue] and [actualValue].
  final int decimalPlaces;

  /// Toggle on and off animation.
  final bool isAnimate;

  /// Sets a duration in milliseconds to control the speed of the animation.
  final int animationDuration;

  /// Sets the stroke width of the ranges.
  final double rangeStrokeWidth;

  /// Sets the [TextStyle] for the actualValue.
  final TextStyle actualValueTextStyle;

  /// Sets the [maxDegree] for the gauge.
  final double maxDegree;

  /// Sets the [startDegree] of the gauge.
  final double startDegree;

  /// Toggle on and off legend.
  final bool isLegend;

  @override
  State<RangeRadialGauge> createState() => _RangeRadialGaugeState();
}

class _RangeRadialGaugeState extends State<RangeRadialGauge>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    double sweepAngleRadian = RadialHelper.actualValueToSweepAngleRadian(
        minValue: widget.minValue,
        actualValue: widget.actualValue,
        maxValue: widget.maxValue,
        maxDegrees: widget.maxDegree);

    double upperBound = RadialHelper.degreesToRadians(widget.maxDegree);

    animationController = AnimationController(
        duration: RadialHelper.getDuration(
            isAnimate: widget.isAnimate,
            userMilliseconds: widget.animationDuration),
        vsync: this,
        upperBound: upperBound);

    animation = Tween<double>().animate(animationController)
      ..addListener(() {
        if (animationController.value == sweepAngleRadian) {
          animationController.stop();
        }

        setState(() {});
      });

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (animationController.value !=
        RadialHelper.actualValueToSweepAngleRadian(
            minValue: widget.minValue,
            actualValue: widget.actualValue,
            maxValue: widget.maxValue,
            maxDegrees: widget.maxDegree)) {
      animationController.animateTo(
          RadialHelper.actualValueToSweepAngleRadian(
              minValue: widget.minValue,
              actualValue: widget.actualValue,
              maxValue: widget.maxValue,
              maxDegrees: widget.maxDegree),
          duration: RadialHelper.getDuration(
              isAnimate: widget.isAnimate,
              userMilliseconds: widget.animationDuration));
    }

    return FittedBox(
      child: Column(
        children: [
          widget.titlePosition == TitlePosition.top
              ? SizedBox(
                  height: widget.rangeStrokeWidth - 10,
                  child: widget.title,
                )
              : const SizedBox(
                  height: 20,
                ),
          SizedBox(
            height: widget.size,
            width: widget.size,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomPaint(
                painter: RangeRadialGaugePainter(
                    sweepAngle: animationController.value,
                    pointerColor: widget.pointerColor,
                    maxValue:
                        widget.maxValue.toStringAsFixed(widget.decimalPlaces),
                    minValue:
                        widget.minValue.toStringAsFixed(widget.decimalPlaces),
                    ranges: widget.ranges,
                    actualValue: widget.actualValue,
                    decimalPlaces: widget.decimalPlaces,
                    strokeWidth: widget.rangeStrokeWidth,
                    actualValueTextStyle: widget.actualValueTextStyle,
                    maxDegree: widget.maxDegree,
                    startDegree: widget.startDegree,
                    isLegend: widget.isLegend,
                    unit: widget.unit),
              ),
            ),
          ),
          SizedBox(
            height: widget.titlePosition == TitlePosition.bottom
                ? widget.rangeStrokeWidth - 10
                : 0,
          ),
          widget.titlePosition == TitlePosition.bottom
              ? SizedBox(
                  height: 30,
                  child: widget.title,
                )
              : const SizedBox(
                  height: 20,
                )
        ],
      ),
    );
  }
}
