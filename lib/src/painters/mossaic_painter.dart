import 'package:flutter/material.dart';

import '../pattern_box_base.dart';
import '../enum/pattern_box_type.dart';

class MosaicPainter extends PatternBox {
  MosaicPainter({Color? color, double? gap, double? thickness})
    : super(
        color: color ?? Colors.grey,
        thickness: thickness ?? 4,
        type: PatternType.mosaic,
        gap: gap ?? 20,
      );

  @override
  void paint(Canvas canvas, Size size) {
    final mosaic = MosaicBlock.fromColor(
      side: gap,
      baseColor: color,
      nx: thickness.toInt(),
      ny: thickness.toInt(),
    );

    final tileSize = mosaic.size;
    for (double y = 0; y < size.height; y += tileSize.height) {
      for (double x = 0; x < size.width; x += tileSize.width) {
        mosaic.paint(canvas, Offset(x, y), thickness);
      }
    }
  }
}

class MosaicBlock {
  final double side;
  final int nx;
  final int ny;
  final List<Color> fillColors;
  final Color strokeColor;

  MosaicBlock({
    required this.side,
    required this.nx,
    required this.ny,
    required this.fillColors,
    required this.strokeColor,
  });
  factory MosaicBlock.fromColor({
    required Color baseColor,
    double side = 20,
    int nx = 4,
    int ny = 4,
  }) {
    HSLColor hsl = HSLColor.fromColor(baseColor);

    List<Color> generateShades() {
      return List.generate(2 * nx * ny, (i) {
        final lightness = (0.3 + (i % 5) * 0.1).clamp(0.0, 1.0);

        if (hsl.saturation < 0.05) {
          return HSLColor.fromAHSL(1.0, 0.0, 0.0, lightness).toColor();
        }

        final adjustedSaturation = (hsl.saturation * 0.9).clamp(0.0, 1.0);
        return hsl
            .withLightness(lightness)
            .withSaturation(adjustedSaturation)
            .toColor();
      });
    }

    return MosaicBlock(
      side: side,
      nx: nx,
      ny: ny,
      fillColors: generateShades(),
      strokeColor: baseColor.withAlpha(77),
    );
  }

  void paint(Canvas canvas, Offset offset, double thickness) {
    final strokePaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = thickness
          ..color = strokeColor;

    for (int y = 0; y < ny; y++) {
      for (int x = 0; x < nx; x++) {
        final i = y * nx + x;
        final pos = Offset(offset.dx + 2 * side * x, offset.dy + 2 * side * y);

        final paint1 = Paint()..color = fillColors[i];
        final paint2 = Paint()..color = fillColors[i + nx * ny];

        final even = (x + y) % 2 == 0;
        if (even) {
          _drawOuter(canvas, pos, strokePaint, paint1);
        } else {
          _drawInner(canvas, pos, strokePaint, paint1, paint2);
        }
      }
    }
  }

  void _drawOuter(Canvas canvas, Offset o, Paint stroke, Paint fill) {
    final p1 =
        Path()
          ..moveTo(o.dx, o.dy + side)
          ..lineTo(o.dx + side, o.dy + 2 * side)
          ..lineTo(o.dx, o.dy + 2 * side)
          ..close();
    final p2 =
        Path()
          ..moveTo(o.dx + 2 * side, o.dy + side)
          ..lineTo(o.dx + side, o.dy + 2 * side)
          ..lineTo(o.dx + 2 * side, o.dy + 2 * side)
          ..close();
    final p3 =
        Path()
          ..moveTo(o.dx, o.dy + side)
          ..lineTo(o.dx + side, o.dy)
          ..lineTo(o.dx, o.dy)
          ..close();
    final p4 =
        Path()
          ..moveTo(o.dx + 2 * side, o.dy + side)
          ..lineTo(o.dx + side, o.dy)
          ..lineTo(o.dx + 2 * side, o.dy)
          ..close();

    for (final p in [p1, p2, p3, p4]) {
      canvas.drawPath(p, stroke);
      canvas.drawPath(p, fill);
    }
  }

  void _drawInner(Canvas canvas, Offset o, Paint stroke, Paint f1, Paint f2) {
    final p1 =
        Path()
          ..moveTo(o.dx + side, o.dy)
          ..lineTo(o.dx, o.dy + side)
          ..lineTo(o.dx + side, o.dy + side)
          ..close();
    final p2 =
        Path()
          ..moveTo(o.dx + side, o.dy + 2 * side)
          ..lineTo(o.dx + 2 * side, o.dy + side)
          ..lineTo(o.dx + side, o.dy + side)
          ..close();
    final p3 =
        Path()
          ..moveTo(o.dx + side, o.dy)
          ..lineTo(o.dx + 2 * side, o.dy + side)
          ..lineTo(o.dx + side, o.dy + side)
          ..close();
    final p4 =
        Path()
          ..moveTo(o.dx + side, o.dy + 2 * side)
          ..lineTo(o.dx, o.dy + side)
          ..lineTo(o.dx + side, o.dy + side)
          ..close();

    for (int i = 0; i < 4; i++) {
      canvas.drawPath([p1, p2, p3, p4][i], stroke);
      canvas.drawPath([p1, p2, p3, p4][i], i < 2 ? f1 : f2);
    }
  }

  Size get size => Size(side * nx * 2, side * ny * 2);
}
