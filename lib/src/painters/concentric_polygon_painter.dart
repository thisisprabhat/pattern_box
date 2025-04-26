import 'dart:math';

import 'package:flutter/material.dart';

import '../enum/pattern_box_type.dart';
import '../pattern_box.dart';

class ConcentricPolygonPainter extends PatternBox {
  final int? count;
  ConcentricPolygonPainter({
    Color? color,

    double? thickness,
    this.count,
    bool? repaint,
  }) : super(
         color: color ?? Colors.grey,
         thickness: thickness ?? 1,
         type: PatternType.concentricPolygon,
         gap: 4,
         repaint: repaint ?? false,
       );

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = thickness
          ..style = PaintingStyle.stroke;
    final int sides = 12;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 2;

    for (int r = 1; r <= (count ?? 5); r++) {
      final path = Path();
      for (int i = 0; i < sides; i++) {
        double angle = (2 * pi * i / sides);
        final x = center.dx + cos(angle) * radius * r / 5;
        final y = center.dy + sin(angle) * radius * r / 5;
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
}
