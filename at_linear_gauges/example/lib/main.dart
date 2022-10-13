import 'package:at_linear_gauges/at_linear_gauges.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Linear gauge Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Scaffold(
          body: SizedBox(
        child: Center(
          child: SimpleLinearGauge(
            maxValue: 100,
            actualValue: 76,
            //Optional Parameters
            minValue: 0,
            divisions: 10,
            size: double.infinity,
            title: const Text('Simple Linear Gauge'),
            titlePosition: TitlePosition.top,
            pointerColor: Colors.blue,
            pointerIcon: const Icon(
              Icons.water_drop,
              color: Colors.blue,
              // size: 40,
            ),
            gaugeOrientation: GaugeOrientation.vertical,
            decimalPlaces: 0,
            isAnimate: true,
            animationDuration: 2000,
            gaugeStrokeWidth: 5,
            rangeStrokeWidth: 5,
            majorTickStrokeWidth: 5,
            minorTickStrokeWidth: 5,
            actualValueTextStyle:
                const TextStyle(color: Colors.black, fontSize: 20),
            majorTickValueTextStyle: const TextStyle(color: Colors.black),
          ),
        ),
      )),
    );
  }
}
