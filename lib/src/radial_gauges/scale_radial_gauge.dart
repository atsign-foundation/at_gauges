import 'package:flutter/material.dart';

import '../painters/radial/scale_radial_gauge_painter.dart';
import '../utils/constants.dart';
import '../utils/enums.dart';
import '../utils/radial_helper.dart';

class ScaleRadialGauge extends StatefulWidget {
  /// Creates a scale Gauge.
  ///
  /// The [minValue] and [maxValue] must not be null.
  const ScaleRadialGauge({
    required this.maxValue,
    required this.actualValue,
    this.minValue = 0,
    this.size = 200,
    this.title,
    this.titlePosition = TitlePosition.top,
    this.pointerColor = Colors.blue,
    this.needleColor = Colors.blue,
    this.decimalPlaces = 0,
    this.isAnimate = true,
    this.animationDuration = kDefaultAnimationDuration,
    this.unit = const TextSpan(text: ''),
    Key? key,
  })  : assert(actualValue <= maxValue,
            'actualValue must be less than or equal to maxValue'),
        assert(size >= 140, 'size must be greater than 75'),
        assert(actualValue >= minValue,
            'actualValue must be greater than or equal to minValue'),
        super(key: key);

  /// Sets the minimum value of the gauge.
  final double minValue;

  /// Sets the max value of the gauge.
  final double maxValue;

  /// Sets the actual value of the gauge.
  final double actualValue;

  final TextSpan unit;

  /// Sets the width and height of the gauge.
  ///
  /// If the parent widget has unconstrained height like a [ListView], wrap the gauge in a [SizedBox] to better control it's size
  final double size;

  /// Sets the title of the gauge.
  final Text? title;

  /// Sets the position of the title.
  final TitlePosition titlePosition;

  /// Sets the pointer color of the gauge.
  final Color pointerColor;

  /// Sets the needle color of the gauge.
  final Color needleColor;

  /// Controls how much decimal places will be shown for the [minValue],[maxValue] and [actualValue].
  final int decimalPlaces;

  /// Toggle on and off animation.
  final bool isAnimate;

  /// Sets a duration in milliseconds to control the speed of the animation.
  final int animationDuration;

  @override
  State<ScaleRadialGauge> createState() => _ScaleRadialGaugeState();
}

class _ScaleRadialGaugeState extends State<ScaleRadialGauge>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    double sweepAngleRadian = RadialHelper.actualValueToSweepAngleRadian(
        actualValue: widget.actualValue,
        maxValue: widget.maxValue,
        minValue: widget.minValue,
        maxDegrees: 300);

    double upperBound = RadialHelper.degreesToRadians(300);

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
            actualValue: widget.actualValue,
            maxValue: widget.maxValue,
            minValue: widget.minValue,
            maxDegrees: 300)) {
      animationController.animateTo(
          RadialHelper.actualValueToSweepAngleRadian(
              actualValue: widget.actualValue,
              maxValue: widget.maxValue,
              minValue: widget.minValue,
              maxDegrees: 300),
          duration: RadialHelper.getDuration(
              isAnimate: widget.isAnimate,
              userMilliseconds: widget.animationDuration));
    }

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: FittedBox(
        child: SizedBox(
          child: Column(
            children: [
              widget.titlePosition == TitlePosition.top
                  ? SizedBox(
                      height: 20,
                      child: widget.title,
                    )
                  : const SizedBox(
                      height: 20,
                    ),
              SizedBox(
                height: 200,
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomPaint(
                    painter: ScaleRadialGaugePainter(
                      sweepAngle: animationController.value,
                      pointerColor: widget.pointerColor,
                      needleColor: widget.needleColor,
                      minValue: widget.minValue,
                      maxValue: widget.maxValue,
                      actualValue: widget.actualValue,
                      decimalPlaces: widget.decimalPlaces,
                      unit: widget.unit,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
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
        ),
      ),
    );
  }
}
