import 'dart:math';

import 'package:flutter/material.dart';

import '../enum/pattern_box_type.dart';
import '../pattern_box.dart';

class HoneyCombPainter extends PatternBox {
  HoneyCombPainter({
    Color? color,
    double? gap,
    double? thickness,
    bool? repaint,
  }) : super(
         color: color ?? Colors.grey,
         thickness: thickness ?? 1,
         type: PatternType.honeyComb,
         gap: gap ?? 10,
         repaint: repaint ?? false,
       );

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = thickness
          ..style = PaintingStyle.stroke;
    final hexHeight = gap * sqrt(3);
    for (double x = 0; x < size.width; x += gap * 1.5) {
      for (double y = 0; y < size.height; y += hexHeight) {
        final offsetY = (x ~/ (gap * 1.5)) % 2 == 0 ? 0 : hexHeight / 2;
        _drawHexagon(canvas, Offset(x, y + offsetY), paint);
      }
    }
  }

  void _drawHexagon(Canvas canvas, Offset center, Paint paint) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      double angle = (pi / 3) * i;
      final x = center.dx + gap * cos(angle);
      final y = center.dy + gap * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }
}
