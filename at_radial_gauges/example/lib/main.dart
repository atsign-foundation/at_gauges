import 'package:at_radial_gauges/at_radial_gauges.dart';
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
        child: ListView(
          children: const [
            SimpleRadialGauge(
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
              size: 400,
            ),
            ScaleRadialGauge(
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
          ],
        ),
      ),
    );
  }
}
