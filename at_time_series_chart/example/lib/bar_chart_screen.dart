import 'dart:async';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:at_time_series_chart/at_time_series_chart.dart';

class BarChartScreen extends StatefulWidget {
  const BarChartScreen({Key? key}) : super(key: key);

  @override
  State<BarChartScreen> createState() => _BarChartScreenState();
}

class _BarChartScreenState extends State<BarChartScreen> {
  // List<BarValue<void>> _values = [];

  List<BarValue<String>> _values = [
    BarValue.withValue("18:16:30", 26),
    BarValue.withValue("18:17:00", 25),
    BarValue.withValue("18:17:30", 29),
    BarValue.withValue("18:18:00", 23),
    BarValue.withValue("18:18:30", 30),
    BarValue.withValue("18:16:30", 26),
    BarValue.withValue("18:17:00", 25),
    BarValue.withValue("18:17:30", 29),
    BarValue.withValue("18:18:00", 23),
    BarValue.withValue("18:18:30", 30),
    // BarValue.withValue("18:19:00", 25),
  ];

  late double targetMax;
  final bool _showValues = true;
  final bool _smoothPoints = false;
  final bool _colorfulBars = false;
  bool _showBars = false;
  bool _showLine = true;
  int minItems = 6;
  final bool _legendOnEnd = false;
  final bool _legendOnBottom = true;

  @override
  void initState() {
    super.initState();
    // _updateValues();

    // Timer.periodic(
    //   const Duration(seconds: 5),
    //   _reloadData,
    // );
  }

  void _fReloadData(Timer timer) {}

  void _reloadData(Timer timer) {
    setState(() {
      _values.add(
        BarValue.withValue(
          DateFormat('HH:mm:ss').format(DateTime.now()),
          Random().nextInt(15) + 20,
        ),
      );
      _values.removeAt(0);
    });
  }

  // void _updateValues() {
  //   final Random rand = Random();
  //   targetMax = 7;
  //   _values.addAll(
  //     List.generate(
  //       minItems,
  //       (index) {
  //         return BarValue<void>(
  //             targetMax * 0.4 + rand.nextDouble() * targetMax * 0.9);
  //       },
  //     ),
  //   );
  // }
  //
  // void _addValues() {
  //   _values = List.generate(minItems, (index) {
  //     if (_values.length > index) {
  //       return _values[index];
  //     }
  //
  //     return BarValue<void>(
  //         targetMax * 0.4 + Random().nextDouble() * targetMax * 0.9);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bar chart',
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.orange,
              margin: EdgeInsets.all(8),
              child: BarChart(
                data: _values,
                axisMin: 20,
                axisMax: 35,
                height: MediaQuery.of(context).size.height * 0.5,
                dataToValue: (BarValue value) => value.max ?? 0.0,
                itemOptions: BarItemOptions(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  minBarWidth: 5.0,
                  color: Colors.brown.withOpacity(_showBars ? 1.0 : 0.0),
                  radius: const BorderRadius.vertical(
                    top: Radius.circular(24.0),
                  ),
                  colorForValue: _colorfulBars
                      ? (_, value, [min]) {
                          int _value =
                              (((value ?? 0) / (targetMax * 1.3)) * 10).round();
                          return Colors.accents[_value];
                        }
                      : null,
                ),
                backgroundDecorations: [
                  GridDecoration(
                    verticalAxisValueFromIndex: (index) {
                      return '${_values[index].value}';
                    },
                    horizontalAxisValueFromValue: (index) {
                      return 'Value $index';
                    },
                    showHorizontalValues: _showValues,
                    showVerticalValues: _showValues,
                    showTopHorizontalValue:
                        _legendOnBottom ? _showValues : false,
                    horizontalLegendPosition: _legendOnEnd
                        ? HorizontalLegendPosition.end
                        : HorizontalLegendPosition.start,
                    verticalLegendPosition: _legendOnBottom
                        ? VerticalLegendPosition.bottom
                        : VerticalLegendPosition.top,
                    horizontalAxisStep: 3,
                    verticalAxisStep: 1,
                    verticalValuesPadding:
                        const EdgeInsets.symmetric(vertical: 4.0),
                    horizontalValuesPadding:
                        const EdgeInsets.symmetric(horizontal: 4.0),
                    textStyle: Theme.of(context).textTheme.caption,
                    gridColor: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.2),
                  ),
                ],

                ///Line Chart
                foregroundDecorations: [
                  SparkLineDecoration(
                    lineWidth: 3.0,
                    lineColor: Colors.red.withOpacity(_showLine ? 1.0 : 0.0),
                    smoothPoints: _smoothPoints,
                  ),
                  ValueDecoration(
                    alignment: _showBars
                        ? Alignment.bottomCenter
                        : const Alignment(0.0, -1.0),
                    textStyle: Theme.of(context).textTheme.button?.copyWith(
                          color: (_showBars
                              ? Theme.of(context).colorScheme.onPrimary
                              : Colors.green),
                        ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      minItems += 4;
                      // _addValues();
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    color: Colors.yellowAccent,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (_values.length > 4) {
                        minItems -= 4;
                        _values.removeRange(_values.length - 4, _values.length);
                      }
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    color: Colors.green,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _showBars = !_showBars;
                      _showLine = !_showLine;
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    color: Colors.red,
                    child: Center(child: Text("Show Bar")),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
