import 'package:flutter/material.dart';

import '../pattern_box.dart';

class PatternBoxWidget extends StatelessWidget {
  const PatternBoxWidget({
    super.key,
    required this.pattern,
    this.child,
    this.backgroundGradient,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.height,
    this.width,
    this.patternGradient,
  });
  final Widget? child;
  final PatternBox pattern;
  final Gradient? backgroundGradient;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final double? height;
  final double? width;

  /// It will override the pattern color
  final Gradient? patternGradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: backgroundColor != null ? null : backgroundGradient,
        color: backgroundColor,
        borderRadius: borderRadius,
        border: border,
      ),
      child:
          patternGradient == null
              ? _pattern
              : Stack(
                alignment: Alignment.center,
                children: [
                  ShaderMask(
                    shaderCallback:
                        (bounds) => patternGradient!.createShader(bounds),
                    blendMode: BlendMode.srcIn,
                    child: _pattern,
                  ),
                  if (child != null) child!,
                ],
              ),
    );
  }

  CustomPaint get _pattern {
    return CustomPaint(
      painter: pattern,
      child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: child,
      ),
    );
  }
}
