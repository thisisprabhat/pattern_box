import 'dart:math';

import 'package:flutter/material.dart';

import '../enum/pattern_box_type.dart';
import '../pattern_box_base.dart';

class DottedWavePainter extends PatternBox {
  DottedWavePainter({Color? color, double? gap, double? thickness})
    : super(
        color: color ?? Colors.grey,
        thickness: thickness ?? 1.5,
        type: PatternType.dottedWave,
        gap: gap ?? 10,
      );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withAlpha(125);

    for (double x = 0; x < size.width; x += gap) {
      for (double y = 0; y < size.height; y += gap) {
        final offset = sin((x + y) * 0.05) * 4;
        canvas.drawCircle(Offset(x, y + offset), thickness, paint);
      }
    }
  }
}
