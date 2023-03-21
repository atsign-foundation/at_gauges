import 'package:at_gauges/at_gauges.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  double _value = 20;
  final double _minValue = 0;
  final double _maxValue = 27;

  Widget myGauges() {
    return Scaffold(
      // appBar: AppBar(title: const Text('Radial Gauges')),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox.shrink()
                  ),
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
                    size: 400,
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox.shrink()
                  ),
                  const ScaleRadialGauge(
                    maxValue: 100,
                    actualValue: 70,
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
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox.shrink()
                  ),
                  SimpleLinearGauge(
                    // size: 600,
                    maxValue: 100,
                    actualValue: 80,
                    //Optional Parameters
                    minValue: -50,
                    divisions: 10,

                    title: const Text('Simple Linear Gauge'),
                    titlePosition: TitlePosition.top,
                    pointerColor: Colors.blue,
                    pointerIcon: const Icon(
                      // Icons.water_drop,
                      Icons.arrow_forward,
                      color: Colors.blue,
                      size: 20,
                    ),
                    decimalPlaces: 0,
                    isAnimate: true,
                    animationDuration: 2000,
                    gaugeOrientation: GaugeOrientation.vertical,
                    gaugeStrokeWidth: 3,
                    rangeStrokeWidth: 3,
                    majorTickStrokeWidth: 2,
                    minorTickStrokeWidth: 1,
                    actualValueTextStyle:
                      const TextStyle(color: Colors.black, fontSize: 12),
                    majorTickValueTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                    unitString: '\u2103',
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox.shrink()
                  ),
                  SimpleLinearGauge(
                    maxValue: 100,
                    actualValue: 80,
                    //Optional Parameters
                    minValue: -40,
                    divisions: 7,
                    title: const Text('Simple Linear Gauge'),
                    titlePosition: TitlePosition.bottom,
                    pointerColor: Colors.blue,
                    pointerIcon: const Icon(
                      Icons.arrow_downward,
                      // Icons.water_drop,
                      color: Colors.blue,
                      size: 15,
                    ),
                    decimalPlaces: 1,
                    isAnimate: true,
                    animationDuration: 125,
                    gaugeOrientation: GaugeOrientation.horizontal,
                    gaugeStrokeWidth: 10,
                    rangeStrokeWidth: 10,
                    majorTickStrokeWidth: 2,
                    minorTickStrokeWidth: 1,
                    actualValueTextStyle:
                    const TextStyle(color: Colors.black, fontSize: 12),
                    majorTickValueTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                    majorTicksDecimalPlace: 0,
                    unitString: '\u2103',
                    size: 400,
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox.shrink()
                  ),
                  const SegmentRadialGauge(
                    maxValue: -50,
                    actualValue: -120,
                    // Optional Parameters
                    minValue: -150,
                    size: 250,
                    title: Text('Zone Radial Gauge'),
                    titlePosition: TitlePosition.top,
                    pointerColor: Colors.cyan,
                    needleColor: Colors.cyan,
                    decimalPlaces: 2,
                    isAnimate: true,
                    animationDuration: 100,
                    unit: TextSpan(
                      text: 'V',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.cyan,
                      ),
                    ),
                    isPointer: true,
                    titleText: "Title",
                    title2Text: "Title2",
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox.shrink()
                  ),
                  SegmentRadialGauge(
                    maxValue: 100,
                    actualValue: 50,
                    // Optional Parameters
                    minValue: 35,
                    size: 250,
                    title: const Text('Zone Radial Gauge'),
                    titlePosition: TitlePosition.top,
                    pointerColor: Colors.cyan,
                    needleColor: Colors.cyan,
                    decimalPlaces: 0,
                    isAnimate: true,
                    animationDuration: 100,
                    unit: const TextSpan(
                      text: 'V',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.cyan,
                      ),
                    ),
                    isPointer: true,
                    titleText: "Title",
                    title2Text: "Title2",
                    segmentList: [
                      ZoneSegment(
                        size: 1,
                        color: Colors.red.withOpacity(0.95),
                      ),
                      ZoneSegment(
                        size: 2,
                        color: Colors.blue.withOpacity(0.95),
                      ),
                      ZoneSegment(
                        size: 3,
                        color: Colors.orangeAccent.withOpacity(0.95),
                      ),
                      ZoneSegment(
                        size: 4,
                        color: Colors.greenAccent.withOpacity(0.95),
                      ),
                    ],
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox.shrink()
                  ),
                  SegmentRadialGauge(
                    maxValue: _maxValue,
                    actualValue: _value,
                    // Optional Parameters
                    minValue: _minValue,
                    size: 250,
                    title: const Text('Zone Radial Gauge'),
                    titlePosition: TitlePosition.top,
                    pointerColor: Colors.cyan,
                    needleColor: Colors.cyan,
                    decimalPlaces: 2,
                    isAnimate: true,
                    animationDuration: 125,
                    unit: const TextSpan(
                      text: 'V',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.cyan,
                      ),
                    ),
                    isPointer: false,
                    titleText: "Title",
                    title2Text: "Title2",
                    segmentStartAngle: 135,
                    segmentSweepAngle: 270,
                    segmentMainNo: 8,
                    segmentSubNo: 5,
                    segmentList: [
                      ZoneSegment(
                        size: 1,
                        color: Colors.red.withOpacity(0.95),
                      ),
                      ZoneSegment(
                        size: 2,
                        color: Colors.blue.withOpacity(0.95),
                      ),
                      ZoneSegment(
                        size: 1,
                        color: Colors.orangeAccent.withOpacity(0.95),
                      ),
                      ZoneSegment(
                        size: 4,
                        color: Colors.greenAccent.withOpacity(0.95),
                      ),
                    ],
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox.shrink()
                  ),
                  Slider(
                    value: _value,
                    min: _minValue + 1,
                    max: _maxValue - 1,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                ],
              ),
            );
          }
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'At Gauges',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: myGauges(),
    );
  }
}
