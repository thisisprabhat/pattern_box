import 'dart:math';

import 'package:flutter/material.dart';

import '../enum/pattern_box_type.dart';
import '../pattern_box.dart';

class CircularPainter extends PatternBox {
  final double? dotSize;
  final bool isDotFilled;
  CircularPainter({
    Color? color,
    double? gap,
    double? thickness,
    this.dotSize,
    this.isDotFilled = false,
    bool? repaint,
  }) : super(
         color: color ?? Colors.grey,
         thickness: thickness ?? 1,
         type: PatternType.circular,
         gap: gap ?? 90,
         repaint: repaint ?? false,
       );

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = thickness;

    for (double y = 0; y < size.height; y += gap) {
      for (double x = 0; x < size.width; x += gap) {
        _drawPattern(canvas, Offset(x, y), paint);
      }
    }
  }

  void _drawPattern(Canvas canvas, Offset center, Paint paint) {
    final int petals = 6;
    final double radius = gap;
    final double innerRadius = radius;
    for (int i = 0; i < petals; i++) {
      final double angle = (2 * 3.1415926 / petals) * i;
      final double dx = center.dx + radius * cos(angle);
      final double dy = center.dy + radius * sin(angle);

      final dotSize = this.dotSize ?? radius / 10;

      final newPaint =
          Paint()
            ..color = color
            ..strokeWidth = thickness
            ..style = isDotFilled ? PaintingStyle.fill : PaintingStyle.stroke;
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(dx, dy),
          width: dotSize,
          height: dotSize,
        ),
        newPaint,
      );
    }

    // Draw center circle
    canvas.drawCircle(center, innerRadius, paint);
  }
}
