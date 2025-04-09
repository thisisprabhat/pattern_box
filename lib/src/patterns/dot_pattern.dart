import 'package:flutter/material.dart';

import '../enum/pattern_box_type.dart';
import '../pattern_box.dart';

class DotPattern extends PatternBoxBase {
  DotPattern({
    Color? color,
    double? gap,
    double? thickness,
  }) : super(
          color: color ?? Colors.red,
          thickness: thickness ?? 2,
          type: PatternBoxType.dot,
          gap: gap ?? 10,
        );

  @override
  void paint(Canvas canvas, Size size) {}
}
