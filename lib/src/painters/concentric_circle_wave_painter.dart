import 'package:flutter/material.dart';

import '../enum/pattern_box_type.dart';
import '../pattern_box_base.dart';

class ConcentricCircleWavePainter extends PatternBox {
  final int? count;
  ConcentricCircleWavePainter({
    Color? color,
    double? gap,
    double? thickness,
    this.count,
  }) : super(
         color: color ?? Colors.grey,
         thickness: thickness ?? 1,
         type: PatternType.concentricCircleWave,
         gap: gap ?? 4,
       );

  @override
  void paint(Canvas canvas, Size size) {
    final count = this.count ?? size.width / gap;
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.shortestSide / 2;
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke;

    for (int i = 1; i <= count; i++) {
      final opacity = 1 - (i / count);
      paint.color = color.withAlpha((255 * opacity).toInt());
      canvas.drawCircle(center, maxRadius * i / 20, paint);
    }
  }
}
