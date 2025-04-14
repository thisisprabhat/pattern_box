import 'dart:math';

import 'package:flutter/material.dart';

import '../enum/pattern_box_type.dart';
import '../pattern_box.dart';

class ConcentricDottedCirclePainter extends PatternBox {
  final int? count;
  final int? maxRadius;
  ConcentricDottedCirclePainter({
    Color? color,
    double? gap,
    double? thickness,
    this.maxRadius,
    this.count,
    bool? repaint,
  }) : super(
         color: color ?? Colors.grey,
         thickness: thickness ?? 2,
         type: PatternType.concentricDottedCircle,
         gap: gap ?? 20,
         repaint: repaint ?? false,
       );

  @override
  void paint(Canvas canvas, Size size) {
    int rays = count ?? 22;
    final center = Offset(size.width / 2, size.height / 2);
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = thickness;

    final maxRadius = this.maxRadius ?? min(size.width, size.height) / 2;
    for (int i = 0; i < rays; i++) {
      double angle = (2 * pi * i) / rays;
      for (double r = 10; r < maxRadius; r += gap) {
        final dx = center.dx + cos(angle) * r;
        final dy = center.dy + sin(angle) * r;
        canvas.drawCircle(Offset(dx, dy), thickness, paint);
      }
    }
  }
}
