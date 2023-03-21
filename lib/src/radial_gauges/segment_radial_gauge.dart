import 'package:flutter/material.dart';

import '../painters/radial/segment_radial_gauge_painter.dart';
import '../utils/constants.dart';
import '../utils/enums.dart';
import '../utils/radial_helper.dart';
import '../utils/zone_segment.dart';

class SegmentRadialGauge extends StatefulWidget {
  /// Creates a scale Gauge.
  ///
  /// The [minValue] and [maxValue] must not be null.
  const SegmentRadialGauge({
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
    this.isPointer = false,
    this.titleText = "",
    this.title2Text = "",
    this.segmentStartAngle = 120,
    this.segmentSweepAngle = 300,
    this.segmentMainNo = 10,
    this.segmentSubNo = 2,
    this.segmentList = const [],
    Key? key,
  }) :
        assert(actualValue <= maxValue,
            'actualValue must be less than or equal to maxValue'),
        assert(size >= 140, 'size must be greater than 75'),
        assert(actualValue >= minValue,
            'actualValue must be greater than or equal to minValue'),
        assert(minValue < maxValue,
            'maxValue must be greater than minValue'),
        assert(segmentStartAngle > 0,
            'segmentStartAngle must be greater than 0'),
        assert(segmentSweepAngle > 0,
            'segmentSweepAngle must be greater than 0'),
        assert(segmentMainNo > 0,
            'segmentMainNo must be greater than 0'),
        assert(segmentSubNo > 0,
            'segmentSubNo must be greater than 0'),
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

  /// Toggle on and off Pointer Arc Animation.
  final bool isPointer;

  /// Set Title Text.
  final String titleText;

  /// Set Title2 Text.
  final String title2Text;

  /// Set Segment Start Angle
  final double segmentStartAngle;

  /// Set Segment Sweep Angle
  final double segmentSweepAngle;

  /// Set Main Segment Number
  final int segmentMainNo;

  /// Set Sub Segment Number
  final int segmentSubNo;

  /// Controls Zone Size & Color
  final List<ZoneSegment> segmentList;

  @override
  State<SegmentRadialGauge> createState() => _SegmentRadialGaugeState();
}

class _SegmentRadialGaugeState extends State<SegmentRadialGauge>
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
        maxDegrees: widget.segmentSweepAngle,
    );

    double upperBound = RadialHelper.degreesToRadians(
        widget.segmentSweepAngle);

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
            maxDegrees: widget.segmentSweepAngle,
        )) {
      animationController.animateTo(
          RadialHelper.actualValueToSweepAngleRadian(
              actualValue: widget.actualValue,
              maxValue: widget.maxValue,
              minValue: widget.minValue,
              maxDegrees: widget.segmentSweepAngle,
          ),
          duration: RadialHelper.getDuration(
              isAnimate: widget.isAnimate,
              userMilliseconds: widget.animationDuration));
    }

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: FittedBox(
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
                  painter: SegmentRadialGaugePainter(
                    sweepAngle: animationController.value,
                    pointerColor: widget.pointerColor,
                    needleColor: widget.needleColor,
                    minValue: widget.minValue,
                    maxValue: widget.maxValue,
                    actualValue: widget.actualValue,
                    decimalPlaces: widget.decimalPlaces,
                    unit: widget.unit,
                    isPointer: widget.isPointer,
                    titleText: widget.titleText,
                    title2Text: widget.title2Text,
                    segmentStartAngle: widget.segmentStartAngle,
                    segmentSweepAngle: widget.segmentSweepAngle,
                    segmentMainNo: widget.segmentMainNo,
                    segmentSubNo: widget.segmentSubNo,
                    segmentList: widget.segmentList,
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
    );
  }
}