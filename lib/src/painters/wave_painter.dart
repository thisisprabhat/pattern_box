import 'dart:math';

import 'package:flutter/material.dart';

import '../enum/pattern_box_type.dart';
import '../pattern_box_base.dart';

class WavePainter extends PatternBox {
  final double frequency;
  final double amplitude;
  WavePainter({
    Color? color,
    double? gap,
    double? thickness,
    this.frequency = 3,
    this.amplitude = 10,
  }) : super(
         color: color ?? Colors.grey,
         thickness: thickness ?? 2,
         type: PatternType.wave,
         gap: gap ?? 20,
       );

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = thickness
          ..style = PaintingStyle.stroke;

    for (double y = 0; y <= size.height; y += gap) {
      final path = Path();
      path.moveTo(0, y);
      for (double x = 0; x <= size.width; x++) {
        path.lineTo(
          x,
          y + sin((x / size.width) * frequency * 2 * pi) * amplitude,
        );
      }
      canvas.drawPath(path, paint);
    }
  }
}
