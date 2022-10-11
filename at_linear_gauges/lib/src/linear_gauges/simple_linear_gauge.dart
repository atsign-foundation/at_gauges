import 'package:at_linear_gauges/at_linear_gauges.dart';
import 'package:at_linear_gauges/src/painters/simple_linear_gauge_painter.dart';
import 'package:flutter/material.dart';

class SimpleLinearGauge extends LinearCustomGauge {
  SimpleLinearGauge({
    required double maxValue,
    required double actualValue,
    double minValue = 0,
    List<Range?> ranges = const [],
    int divisions = 10,
    double size = double.infinity,
    Text title = const Text(''),
    TitlePosition titlePosition = TitlePosition.top,
    Color pointerColor = Colors.blue,
    Icon pointerIcon = const Icon(
      Icons.arrow_right_sharp,
      color: Colors.black,
    ),
    GaugeOrientation gaugeOrientation = GaugeOrientation.vertical,
    int decimalPlaces = 0,
    bool isAnimate = true,
    int animationDuration = kDefaultAnimationDuration,
    double gaugeStrokeWidth = 5.0,
    double rangeStrokeWidth = 5.0,
    double majorTickStrokeWidth = 5,
    double minorTickStrokeWidth = 5.0,
    TextStyle actualValueTextStyle = const TextStyle(color: Colors.black),
    TextStyle majorTickValueTextStyle = const TextStyle(color: Colors.black),
  })  : assert(rangeStrokeWidth <= gaugeStrokeWidth,
            'rangeStrokeWidth must not be greater than gaugeStrokeWidth'),
        super(
          minValue: minValue,
          maxValue: maxValue,
          actualValue: actualValue,
          ranges: ranges,
          divisions: divisions,
          size: size,
          title: title,
          titlePosition: titlePosition,
          pointerColor: pointerColor,
          pointerIcon: pointerIcon,
          decimalPlaces: decimalPlaces,
          isAnimate: isAnimate,
          milliseconds: animationDuration,
          gaugeStrokeWidth: gaugeStrokeWidth,
          rangeStrokeWidth: rangeStrokeWidth,
          majorTickStrokeWidth: majorTickStrokeWidth,
          minorTickStrokeWidth: minorTickStrokeWidth,
          actualValueTextStyle: actualValueTextStyle,
          majorTicksValueTextStyle: majorTickValueTextStyle,
          gaugeOrientation: gaugeOrientation,
        );

  @override
  State<SimpleLinearGauge> createState() => _SimpleLinearGaugeState();
}

class _SimpleLinearGaugeState extends State<SimpleLinearGauge>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        duration: Helper.getDuration(
            isAnimate: widget.isAnimate, userMilliseconds: widget.milliseconds),
        vsync: this,
        upperBound: widget.maxValue);

    animation = Tween<double>().animate(animationController)
      ..addListener(() {
        if (animationController.value == widget.actualValue) {
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
    if (animationController.value != widget.actualValue) {
      animationController.animateTo(widget.actualValue);
    }
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: FittedBox(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CustomPaint(
            painter: SimpleLinearGaugePainter(
              maxValue: widget.maxValue,
              minValue: widget.minValue,
              actualValue: animationController.value,
              ranges: widget.ranges,
              divisions: widget.divisions,
              title: widget.title,
              titlePosition: widget.titlePosition,
              pointerColor: widget.pointerColor,
              pointerIcon: widget.pointerIcon,
              decimalPlaces: widget.decimalPlaces,
              rangeStrokeWidth: widget.rangeStrokeWidth,
              gaugeStrokeWidth: widget.gaugeStrokeWidth,
              majorTickStrokeWidth: widget.majorTickStrokeWidth,
              minorTickStrokeWidth: widget.minorTickStrokeWidth,
              actualValueTextStyle: widget.actualValueTextStyle,
              majorTicksValueTextStyle: widget.majorTicksValueTextStyle,
              gaugeOrientation: widget.gaugeOrientation,
            ),
          ),
        ),
      ),
    );
  }
}
