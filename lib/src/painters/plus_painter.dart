import 'package:flutter/material.dart';

import '../enum/pattern_box_type.dart';
import '../pattern_box_base.dart';

class PlusPainter extends PatternBox {
  PlusPainter({Color? color, double? gap, double? thickness, bool? repaint})
    : super(
        color: color ?? Colors.grey.withAlpha(100),
        thickness: thickness ?? 1,
        type: PatternType.plus,
        gap: gap ?? 10,
        repaint: repaint ?? false,
      );

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = thickness
          ..style = PaintingStyle.stroke;

    final width = size.width;
    final height = size.height;

    // Calculate the number of plus signs that fit horizontally and vertically
    final numHorizontal = (width / (gap + gap)).ceil();
    final numVertical = (height / (gap + gap)).ceil();

    // Draw plus signs
    for (int row = 0; row < numVertical; row++) {
      for (int col = 0; col < numHorizontal; col++) {
        final startX = col * (gap + gap) + gap / 2;
        final startY = row * (gap + gap) + gap / 2;

        // Draw the vertical line
        canvas.drawLine(
          Offset(startX + gap / 2, startY),
          Offset(startX + gap / 2, startY + gap),
          paint,
        );

        // Draw the horizontal line
        canvas.drawLine(
          Offset(startX, startY + gap / 2),
          Offset(startX + gap, startY + gap / 2),
          paint,
        );
      }
    }
  }
}
