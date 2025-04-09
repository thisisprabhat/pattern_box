import 'package:flutter/material.dart';

import '../enum/pattern_box_type.dart';
import '../pattern_box_base.dart';

class StripePattern extends PatternBox {
  final Alignment startsFrom;
  StripePattern({
    Color? color,
    double? gap,
    double? thickness,
    this.startsFrom = Alignment.topCenter,
  }) : super(
         color: color ?? Colors.grey,
         thickness: thickness ?? 2,
         type: PatternType.stripe,
         gap: gap ?? 10,
       );

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..color = color
          ..strokeWidth = thickness;

    if (startsFrom == Alignment.topLeft ||
        startsFrom == Alignment.bottomRight) {
      // 🔺 Diagonal stripes (top-left to bottom-right)
      for (double i = -size.height; i < size.width; i += gap) {
        canvas.drawLine(
          Offset(i, 0),
          Offset(i + size.height, size.height),
          paint,
        );
      }
    } else if (startsFrom == Alignment.topRight ||
        startsFrom == Alignment.bottomLeft) {
      // 🔻 Diagonal stripes (top-right to bottom-left)
      for (double i = -size.height; i < size.width + size.height; i += gap) {
        canvas.drawLine(
          Offset(size.width - i, 0),
          Offset(size.width - i - size.height, size.height),
          paint,
        );
      }
    } else if (startsFrom == Alignment.centerLeft ||
        startsFrom == Alignment.centerRight) {
      // 🟦 Vertical stripes (center-left to center-right)
      for (double x = 0; x < size.width; x += gap) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      }
    } else {
      // 🟩 Horizontal stripes
      for (double y = 0; y < size.height; y += gap) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      }
    }
  }
}
