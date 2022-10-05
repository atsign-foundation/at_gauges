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
          children: [
            const SizedBox(
              height: 350,
              child: SimpleRadialGauge(
                actualValue: 50,
                maxValue: 100,
                icon: Icon(Icons.water),
                unit: 'L',
                animationDuration: 500,
                title: Text('Simple Radial Gauge'),
                titlePosition: TitlePosition.top,
              ),
            ),
            const SizedBox(
              height: 350,
              child: ScaleRadialGauge(
                maxValue: 100,
                actualValue: 50,
                unit: TextSpan(text: 'Km/hr', style: TextStyle(fontSize: 9)),
                title: Text('Scale Radial Gauge'),
                titlePosition: TitlePosition.bottom,
              ),
            ),
            SizedBox(
              height: 350,
              child: RangeRadialGauge(
                minValue: 0,
                maxValue: 100,
                actualValue: 50,
                maxDegree: 180,
                startDegree: 180,
                title: const Text('Range Radial Gauge'),
                titlePosition: TitlePosition.bottom,
                unit: const TextSpan(text: '°C'),
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
                    upperLimit: 100,
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
            ),
            const Text('Hi'),
          ],
        ),
      ),
    );
  }
}
