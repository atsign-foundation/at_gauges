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
            title: const Text('Simple Linear Gauge'),
            titlePosition: TitlePosition.top,
            gaugeOrientation: GaugeOrientation.vertical,
            minValue: 0,
            maxValue: 100,
            actualValue: 60,
            pointerIcon: const Icon(
              Icons.arrow_right,
              // size: 70,
            ),
          ),
        ),
      )),
    );
  }
}
