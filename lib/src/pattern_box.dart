import 'package:flutter/material.dart';

import 'enum/pattern_box_type.dart';
import 'utils/string_ext.dart';

abstract class PatternBoxBase extends CustomPainter {
  final double gap;
  final Color color;
  final double thickness;
  final PatternBoxType type;

  PatternBoxBase({
    super.repaint,
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
    return false;
  }

  @override
  String toString() {
    return '${runtimeType.toString().toTitleCase}(color: $color, gap: $gap, thickness: $thickness, type: $type)';
  }
}
