import 'package:flutter/material.dart';

class LinearGauge extends StatefulWidget {
  LinearGauge({
    required this.maxValue,
    required this.minValue,
    required this.actualValue,
    Key? key,
  }) : super(key: key);

  final double maxValue;
  final double minValue;
  final double actualValue;

  @override
  State<LinearGauge> createState() => _LinearGaugeState();
}

class _LinearGaugeState extends State<LinearGauge> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LinearGaugeCustomPainter(),
    );
  }
}

class LinearGaugeCustomPainter extends CustomPainter {
  final double kMainAxisUpperLimit = 7;
  final double kMainAxisLowerLimit = 1.2;

  ///find scale lowest value
  double getMainAxisLowerLimit(Size size) => size.height / kMainAxisLowerLimit;

  ///find scale highest value
  double getMainAxisUpperLimit(Size size) => size.height / kMainAxisUpperLimit;
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
