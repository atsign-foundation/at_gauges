import 'dart:async';
import 'dart:math';

import 'package:at_time_series_chart/at_time_series_chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AtTimeSeriesData data;

  @override
  void initState() {
    super.initState();
    data = AtTimeSeriesData(
      timeSpots: [],
      numOfIntervals: 100,
      intervalTimeInSeconds: 0.1,
      minY: 10,
      maxY: 100,
      backgroundColor: Colors.green,
      xAxisTitle: const Text("abc", style: TextStyle(color: Colors.black)),
      yAxisTitle: const Text("xyz", style: TextStyle(color: Colors.black)),
    );
    _initialSetup();
  }

  void _initialSetup() {
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      data.timeSpots.add(AtTimeSpot(DateTime.now(), Random().nextInt(90) + 10));
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AtTimeSeriesLineChart(
            data: data,
          ),
          const SizedBox(height: 50),
          AtTimeSeriesBarChart(
            data: data,
          ),
        ],
      ),
    );
  }
}
