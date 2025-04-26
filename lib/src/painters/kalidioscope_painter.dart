import 'package:flutter/material.dart';
import 'dart:math';

import '../../pattern_box.dart';

class KaleidoscopePainter extends PatternBox {
  final int seed;
  final List<Color>? colors;

  KaleidoscopePainter({
    this.colors,
    super.color = Colors.grey,
    int? seed,
    super.repaint = true,
  }) : seed = seed ?? DateTime.now().millisecondsSinceEpoch,
       super(gap: 10, type: PatternType.kaleidoscope, thickness: 2);

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(seed);
    final paint =
        Paint()
          ..style = PaintingStyle.fill
          ..color = color;

    final maxRadius = sqrt(size.width * size.width + size.height * size.height);

    void drawPolygon(
      Canvas canvas,
      Offset center,
      double radius,
      Paint paint,
      int sides,
    ) {
      final path = Path();
      for (int i = 0; i < sides; i++) {
        final angle = (2 * pi / sides) * i;
        final x = center.dx + radius * cos(angle);
        final y = center.dy + radius * sin(angle);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas.drawPath(path, paint);
    }

    for (int i = 0; i < random.nextInt(50) + 20; i++) {
      final patternCenter = Offset(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height,
      );

      final patternRadius = random.nextDouble() * (maxRadius / 10);
      final numSides = random.nextInt(6) + 3; // Random polygons with 3-8 sides

      paint.color =
          colors != null
              ? colors![random.nextInt(colors!.length)]
              : color.withAlpha((random.nextDouble() * 255).toInt());

      drawPolygon(canvas, patternCenter, patternRadius, paint, numSides);
    }
  }
}
