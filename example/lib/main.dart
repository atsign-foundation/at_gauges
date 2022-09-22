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
        child: ListView(
          children: [
            const SizedBox(
              height: 350,
              child: SimpleGauge(
                minValue: 0,
                actualValue: 50,
                maxValue: 100,
                icon: Icon(Icons.water),
                duration: 500,
                title: Text(
                  'Simple Gauge',
                ),
              ),
            ),
            const SizedBox(
              height: 350,
              child: ScaleGauge(
                minValue: 0,
                maxValue: 100,
                actualValue: 70,
                title: Text('Scale Gauge'),
              ),
            ),
            SizedBox(
              height: 350,
              child: RangeGauge(
                minValue: 0,
                maxValue: 75,
                actualValue: 50,
                maxDegree: 180,
                startDegree: 180,
                isLegend: true,
                title: const Text('Range Gauge'),
                titlePosition: TitlePosition.top,
                ranges: [
                  Range(
                    label: 'slow',
                    lowerLimit: 0,
                    upperLimit: 25,
                    backgroundColor: Colors.blue,
                  ),
                  Range(
                    label: 'medium',
                    lowerLimit: 25,
                    upperLimit: 50,
                    backgroundColor: Colors.orange,
                  ),
                  Range(
                    label: 'fast',
                    lowerLimit: 50,
                    upperLimit: 75,
                    backgroundColor: Colors.lightGreen,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
