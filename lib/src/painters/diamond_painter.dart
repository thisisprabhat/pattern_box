import 'dart:math';

import 'package:flutter/material.dart';

import '../enum/pattern_box_type.dart';
import '../pattern_box.dart';

class DiamondPainter extends PatternBox {
  DiamondPainter({Color? color, double? gap, double? thickness, bool? repaint})
    : super(
        color: color ?? Colors.grey,
        thickness: thickness ?? 12,
        type: PatternType.diamond,
        gap: gap ?? 30,
        repaint: repaint ?? false,
      );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    for (double x = 0; x < size.width; x += gap) {
      for (double y = 0; y < size.height; y += gap) {
        canvas.save();
        canvas.translate(x + gap / 2, y + gap / 2);
        canvas.rotate(pi / 4);
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset(0, 0),
            width: thickness,
            height: thickness,
          ),
          paint,
        );
        canvas.restore();
      }
    }
  }
}
