import 'package:flutter/material.dart';

import '../pattern_box.dart';
import 'painters/stars_painter.dart';
import 'utils/extensions.dart';

abstract class PatternBox extends CustomPainter {
  final double gap;
  final Color color;
  final double thickness;
  final PatternType type;
  final bool repaint;

  String get patternName => type.name.toTitleCase;

  PatternBox({
    required this.repaint,
    required this.gap,
    required this.type,
    required this.color,
    required this.thickness,
  });

  @override
  @protected
  void paint(Canvas canvas, Size size);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return repaint;
  }

  @override
  String toString() {
    return '${runtimeType.toString().toTitleCase.toPascalCase}(color: ${color.toHex}, gap: $gap, thickness: $thickness, type: $type)';
  }

  static List<PatternBox> get patternList => [
    StripePattern(),
    HoneyCombPainter(),
    ConcentricCircleWavePainter(),
    ConcentricDottedCirclePainter(),
    ConcentricPolygonPainter(),
    ConcentricCirclePainter(),
    WavePainter(),
    DottedWavePainter(),
    DotsPainter(),
    DiamondPainter(),
    GridPainter(),
    CheckerboxPainter(),
    PlusPainter(),
    CircularPainter(),
    WebMatrixPainter(),
    IsometricGridPainter(),
    IsometricGrid3DPainter(),
    MosaicPainter(),
    StarsPainter(),
    KaleidoscopePainter(),
  ];
}
