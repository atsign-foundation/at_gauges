// import 'package:flutter/widgets.dart';

// mixin RadialGauges {
//   void positionTitle(Size size, Canvas canvas) {
//     final TextPainter valueTextPainter = TextPainter(
//         text: TextSpan(
//           style: actualValueTextStyle ??
//               const TextStyle(
//                 color: Colors.black,
//               ),
//           text: Utils.sweepAngleRadianToActualValue(
//                   sweepAngle: sweepAngle,
//                   maxValue: double.parse(maxValue),
//                   minValue: double.parse(minValue),
//                   maxDegrees: maxDegree)
//               .toStringAsFixed(decimalPlaces),
//         ),
//         textDirection: TextDirection.ltr)
//       ..layout();

//       valueTextPainter.paint(canvas, actualValueOffset);
//   }
// }
