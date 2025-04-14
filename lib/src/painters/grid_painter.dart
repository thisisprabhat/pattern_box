import 'package:flutter/material.dart';

import '../enum/pattern_box_type.dart';
import '../pattern_box.dart';

class GridPainter extends PatternBox {
  GridPainter({Color? color, double? gap, double? thickness, bool? repaint})
    : super(
        color: color ?? Colors.grey,
        thickness: thickness ?? 0.2,
        type: PatternType.grid,
        gap: gap ?? 10,
        repaint: repaint ?? false,
      );

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = thickness;

    for (double x = 0; x <= size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }
}
