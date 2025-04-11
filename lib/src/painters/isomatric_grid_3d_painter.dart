import 'dart:math';

import 'package:flutter/material.dart';

import '../../pattern_box.dart';

class IsometricGrid3DPainter extends PatternBox {
  IsometricGrid3DPainter({
    Color? color,
    double? gap,
    double? thickness,
    bool? repaint,
  }) : super(
         color: color ?? Colors.grey,
         thickness: thickness ?? 0.4,
         gap: gap ?? 30,
         type: PatternType.isometric3D,
         repaint: repaint ?? false,
       );

  @override
  void paint(Canvas canvas, Size size) {
    final double h = gap * sqrt(3) / 2;
    final paint = Paint()..style = PaintingStyle.fill;

    for (double y = 0; y < size.height + h; y += h) {
      for (double x = 0; x < size.width + gap; x += gap) {
        final offsetX = (y ~/ (2 * h)) % 2 == 0 ? 0 : gap / 2;
        final center = Offset(x + offsetX, y);

        _drawCube(canvas, center, gap, paint);
      }
    }
  }

  void _drawCube(Canvas canvas, Offset center, double size, Paint paint) {
    final double h = size * sqrt(3) / 2;

    // Points
    final top = Offset(center.dx, center.dy - h / 2);
    final left = Offset(center.dx - size / 2, center.dy);
    final right = Offset(center.dx + size / 2, center.dy);
    final bottom = Offset(center.dx, center.dy + h / 2);

    // Top Face
    paint.color = color.withAlpha((0.8 * 255).toInt());
    canvas.drawPath(
      Path()
        ..moveTo(top.dx, top.dy)
        ..lineTo(left.dx, left.dy)
        ..lineTo(center.dx, center.dy)
        ..lineTo(right.dx, right.dy)
        ..close(),
      paint,
    );

    // Left Face
    paint.color = color.withAlpha((0.6 * 255).toInt());
    canvas.drawPath(
      Path()
        ..moveTo(left.dx, left.dy)
        ..lineTo(bottom.dx, bottom.dy)
        ..lineTo(center.dx, center.dy)
        ..close(),
      paint,
    );

    // Right Face
    paint.color = color.withAlpha((0.4 * 255).toInt());
    canvas.drawPath(
      Path()
        ..moveTo(right.dx, right.dy)
        ..lineTo(bottom.dx, bottom.dy)
        ..lineTo(center.dx, center.dy)
        ..close(),
      paint,
    );
  }
}
