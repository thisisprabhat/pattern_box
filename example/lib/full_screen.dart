import 'package:flutter/material.dart';
import 'package:pattern_box/pattern_box.dart';

class FullScreenPattern extends StatelessWidget {
  final PatternBox patternBox;
  const FullScreenPattern({super.key, required this.patternBox});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(patternBox.patternName)),
      body: CustomPaint(
        painter: patternBox,
        child: SizedBox(height: double.maxFinite, width: double.maxFinite),
      ),
    );
  }
}
