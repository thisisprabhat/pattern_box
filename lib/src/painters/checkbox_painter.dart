import 'package:flutter/material.dart';

import '../enum/pattern_box_type.dart';
import '../pattern_box.dart';

class CheckerboxPainter extends PatternBox {
  CheckerboxPainter({
    Color? color,
    double? gap,
    double? thickness,
    bool? repaint,
  }) : super(
         color: color ?? Colors.grey,
         thickness: thickness ?? 1,
         type: PatternType.checkbox,
         gap: gap ?? 10,
         repaint: repaint ?? false,
       );

  @override
  void paint(Canvas canvas, Size size) {
    for (double x = 0; x < size.width; x += gap) {
      for (double y = 0; y < size.height; y += gap) {
        final isEven = ((x / gap).floor() + (y / gap).floor()) % 2 == 0;
        final paint = Paint()..color = isEven ? color : color.withAlpha(100);
        canvas.drawRect(Rect.fromLTWH(x, y, gap, gap), paint);
      }
    }
  }
}
