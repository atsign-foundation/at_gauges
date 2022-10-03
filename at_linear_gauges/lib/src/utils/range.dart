import 'package:flutter/material.dart';

class Range {
  Range(
      {this.label,
      required this.lowerLimit,
      required this.upperLimit,
      required this.backgroundColor,
      this.legendTextStyle})
      : assert(lowerLimit <= upperLimit,
            'lowerLimit must be less than or equal to upperLimit');

  /// Sets the label of the range.
  final String? label;

  /// Sets the [lowerLimit] of the range.
  final double lowerLimit;

  /// Sets the [upperLimit] of the range.
  final double upperLimit;

  /// Sets the color of the range.
  final Color backgroundColor;

  /// Sets the TextStyle for the [label].
  final TextStyle? legendTextStyle;
}
