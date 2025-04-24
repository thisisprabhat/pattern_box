import 'dart:math';

import 'package:flutter/material.dart';

import '../../pattern_box.dart';

class StarsPainter extends PatternBox {
  final Random random = Random();
  final List<Offset> starPositions = [];
  final List<double> starRadii = [];
  final List<Color> colors;
  final int starsCount;

  StarsPainter({
    super.repaint = false,
    super.type = PatternType.stars,
    this.colors = const [Colors.grey],
    this.starsCount = 600,
  }) : super(color: Colors.white, thickness: 1.0, gap: 10.0);

  void _generateStars(Size size) {
    for (int i = 0; i < starsCount; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      double radius = random.nextDouble() * 3 + 1;
      starPositions.add(Offset(x, y));
      starRadii.add(radius);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    _generateStars(size);
    final Paint starPaint = Paint();

    for (int i = 0; i < starPositions.length; i++) {
      drawStar(canvas, starPositions[i], starRadii[i], starPaint);
    }
  }

  void drawStar(Canvas canvas, Offset center, double radius, Paint paint) {
    final Path starPath = Path();
    final int points = random.nextInt(5) + 4;
    final double angle = (2 * pi) / points;

    paint.color = colors[random.nextInt(colors.length)];

    for (int i = 0; i < points; i++) {
      double x = center.dx + radius * cos(i * angle);
      double y = center.dy + radius * sin(i * angle);
      if (i == 0) {
        starPath.moveTo(x, y);
      } else {
        starPath.lineTo(x, y);
      }

      double innerX = center.dx + (radius / 2) * cos((i + 0.5) * angle);
      double innerY = center.dy + (radius / 2) * sin((i + 0.5) * angle);
      starPath.lineTo(innerX, innerY);
    }
    starPath.close();
    canvas.drawPath(starPath, paint);
  }
}
