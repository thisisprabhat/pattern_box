import 'dart:math';

import 'package:flutter/material.dart';

import '../enum/pattern_box_type.dart';
import '../pattern_box_base.dart';

class WebMatrixPainter extends PatternBox {
  final int points;
  final int layers;
  WebMatrixPainter({
    Color? color,
    double? gap,
    double? thickness,
    this.points = 12,
    this.layers = 6,
  }) : super(
         color: color ?? Colors.grey,
         thickness: thickness ?? 1.5,
         type: PatternType.webMatrix,
         gap: gap ?? 34,
       );

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.shortestSide / 2;
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = thickness
          ..style = PaintingStyle.stroke;

    for (int i = 1; i <= layers; i++) {
      final radius = maxRadius * i / layers;
      final path = Path();
      for (int j = 0; j <= points; j++) {
        final angle = 2 * pi * j / points;
        final x = center.dx + radius * cos(angle);
        final y = center.dy + radius * sin(angle);
        if (j == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      canvas.drawPath(path, paint);
    }

    for (int j = 0; j < points; j++) {
      final angle = 2 * pi * j / points;
      final x = center.dx + maxRadius * cos(angle);
      final y = center.dy + maxRadius * sin(angle);
      canvas.drawLine(center, Offset(x, y), paint);
    }
  }
}
