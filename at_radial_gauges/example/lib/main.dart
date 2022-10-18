import 'package:at_radial_gauges/at_radial_gauges.dart';
import 'package:flutter/material.dart';
import 'package:at_radial_gauges/at_radial_gauges.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'At Gauges',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyGauges(),
    );
  }
}

class MyGauges extends StatelessWidget {
  const MyGauges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width - 50;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: RangeRadialGauge(
            size: sizeWidth,
            rangeStrokeWidth: 85,
            maxValue: 75,
            actualValue: 50,
            startDegree: 180,
            maxDegree: 180,
            title: 'Range Radial Gauge',
            titlePosition: TitlePosition.bottom,
            ranges: [
              Range(
                label: 'slow',
                lowerLimit: 0,
                upperLimit: 50,
                backgroundColor: Colors.green,
              ),
              Range(
                label: 'medium',
                lowerLimit: 50,
                upperLimit: 70,
                backgroundColor: Colors.orange,
              ),
              Range(
                label: 'fast',
                lowerLimit: 70,
                upperLimit: 75,
                backgroundColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
