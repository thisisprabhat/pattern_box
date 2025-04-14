import 'package:flutter/material.dart';

import '../enum/pattern_box_type.dart';
import '../pattern_box.dart';

class ConcentricCirclePainter extends PatternBox {
  final int? count;
  ConcentricCirclePainter({
    Color? color,
    double? gap,
    double? thickness,
    this.count,
    bool? repaint,
  }) : super(
         color: color ?? Colors.grey,
         thickness: thickness ?? 1,
         type: PatternType.circular,
         gap: gap ?? 4,
         repaint: repaint ?? false,
       );

  @override
  void paint(Canvas canvas, Size size) {
    final count = size.width / gap;
    final center = Offset(size.width / 2, size.height / 2);
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = thickness
          ..style = PaintingStyle.stroke;

    for (int i = 1; i <= count; i++) {
      canvas.drawCircle(center, i * (gap * 2), paint);
    }
  }
}
