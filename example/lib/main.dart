import 'package:at_gauges/at_gauges.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      // appBar: AppBar(title: const Text('Radial Gauges')),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            const SimpleRadialGauge(
              actualValue: 50,
              maxValue: 100,
              // Optional Parameters
              minValue: 0,
              title: Text('Simple Radial Gauge'),
              titlePosition: TitlePosition.top,
              unit: 'L',
              icon: Icon(Icons.water),
              pointerColor: Colors.blue,
              decimalPlaces: 0,
              isAnimate: true,
              animationDuration: 2000,
              size: 200,
            ),
            const ScaleRadialGauge(
              maxValue: 100,
              actualValue: 50,
              // Optional Parameters
              minValue: 0,
              size: 400,
              title: Text('Scale Radial Gauge'),
              titlePosition: TitlePosition.top,
              pointerColor: Colors.blue,
              needleColor: Colors.blue,
              decimalPlaces: 0,
              isAnimate: true,
              animationDuration: 2000,
              unit: TextSpan(text: 'Km/h', style: TextStyle(fontSize: 10)),
            ),
            SimpleLinearGauge(
              maxValue: 100,
              actualValue: 76,
              //Optional Parameters
              minValue: 0,
              divisions: 10,

              title: const Text('Simple Linear Gauge'),
              titlePosition: TitlePosition.top,
              pointerColor: Colors.blue,
              pointerIcon: const Icon(
                Icons.water_drop,
                color: Colors.blue,
                // size: 40,
              ),
              decimalPlaces: 0,
              isAnimate: true,
              animationDuration: 2000,
              gaugeOrientation: GaugeOrientation.vertical,
              gaugeStrokeWidth: 5,
              rangeStrokeWidth: 5,
              majorTickStrokeWidth: 3,
              minorTickStrokeWidth: 3,
              actualValueTextStyle:
                  const TextStyle(color: Colors.black, fontSize: 15),
              majorTickValueTextStyle: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
