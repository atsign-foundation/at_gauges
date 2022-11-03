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
      numOfIntervals: 5,
      intervalTimeInSeconds: 0.1,
      drawYAxisTitle: true,
      minY: 0,
      maxY: 100,
      chartPadding: const EdgeInsets.only(left: 35, bottom: 30, right: 30),
      chartSeriesColor: Colors.orange,
      backgroundColor: Colors.white,
      xAxisTitle: const Text(
        "abc",
        style: TextStyle(
          color: Colors.black,
          fontSize: 11,
        ),
      ),
      yAxisTitle: const Text(
        "xyz",
        style: TextStyle(
          color: Colors.black,
          fontSize: 11,
        ),
      ),
    );
    _initialSetup();
  }

  void _initialSetup() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      data.timeSpots.add(
        AtTimeSpot(DateTime.now(), Random().nextInt(70) + 30),
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.blue,
              height: 20,
              width: double.infinity,
            ),
            Container(
              color: Colors.red,
              // width: 300,
              // height: 400,
              child: AtTimeSeriesLineChart(
                data: data,
              ),
            ),
            Container(
              color: Colors.blue,
              height: 20,
              width: double.infinity,
            ),
            // const SizedBox(height: 50),
            AtTimeSeriesBarChart(
              data: data,
            ),
          ],
        ),
      ),
    );
  }
}
