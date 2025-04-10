import 'dart:math';

import 'package:flutter/material.dart';

import '../../pattern_box.dart';

class IsometricGridPainter extends PatternBox {
  IsometricGridPainter({Color? color, double? gap, double? thickness})
    : super(
        color: color ?? Colors.grey,
        thickness: thickness ?? 0.4,
        gap: gap ?? 30,
        type: PatternType.isometric,
      );

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = thickness;

    final double height = gap * sqrt(3) / 2;

    // Diagonal lines going bottom-right (\)
    for (double x = -size.height; x < size.width + size.height; x += gap) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x - size.height, size.height),
        paint,
      );
    }

    // Diagonal lines going bottom-left (/)
    for (double x = -size.width; x < size.width + size.height; x += gap) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.height, size.height),
        paint,
      );
    }

    // Horizontal lines
    for (double y = 0; y <= size.height; y += height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }
}
