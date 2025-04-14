import 'package:flutter/material.dart';

import '../enum/pattern_box_type.dart';
import '../pattern_box.dart';

class DotsPainter extends PatternBox {
  DotsPainter({Color? color, double? gap, double? thickness, bool? repaint})
    : super(
        color: color ?? Colors.grey,
        thickness: thickness ?? 10,
        type: PatternType.dots,
        gap: gap ?? 10,
        repaint: repaint ?? false,
      );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final yCount = (size.height / (gap * 2)).ceil();
    final xCount = (size.width / (gap * 2)).ceil();

    for (var i = 0; i < yCount; i++) {
      final y = gap * (2 * i + 1);
      for (var j = 0; j < xCount; j++) {
        final x = gap * (2 * j + 1);
        canvas.drawCircle(Offset(x, y), thickness / 2, paint);
      }
    }
  }
}
