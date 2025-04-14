import 'package:flutter/material.dart';

typedef PatterBuiilder = Widget Function(double value);

///## This widget is created for animating Patterns
///```
/// AnimatedPatternBuilder(
///  repeat: true,
///  patterBuiilder: (value) {
///    return patternBox(
///      context,
///      GridPainter(repaint: true, gap: 10 + 1 * value),
///    );
///  },
///)
///````
///## Use Cases
///
///### Changing Color Value
/// `final color = Color.lerp(Colors.blue, Colors.red, value)!;`
///### Parameter tweaking
///`GridPainter(repaint: true, gap: 10 + 1 * value)`
///### Switching Between widgets
///```
/// patterBuiilder: (value) {
///  final bool first = value < 0.5;
///  return patternBox(
///    context,
///    first
///        ? GridPainter(repaint: true, gap: 10 + 10 * value)
///        : PlusPainter(repaint: true, gap: 10 + 10 * (1 - value)),
///  );
///}
///```
///### Pattern Transformation
///```
///patterBuiilder: (value) {
///  final scale = 1 + 0.2 * value;
///  final rotation = value * 3.14;

///  return Transform.scale(
///    scale: scale,
///    child: Transform.rotate(
///      angle: rotation,
///      child: patternBox(
///        context,
///        WebMatrixPainter(repaint: true, gap: 10 + value * 5),
///      ),
///    ),
///  );
///}
///```
///
class AnimatedPatternBuilder extends StatefulWidget {
  const AnimatedPatternBuilder({
    super.key,
    required this.patterBuiilder,
    this.repeat = true,
    this.reverse = true,
    this.initialDelayInMS = 100,
    this.durationInMS = 1000,
    this.curve = Curves.linear,
    this.reverseCurve = Curves.linear,
  });
  final PatterBuiilder patterBuiilder;
  final bool repeat;
  final bool reverse;
  final int durationInMS;
  final int initialDelayInMS;
  final Curve curve;
  final Curve reverseCurve;

  @override
  State<AnimatedPatternBuilder> createState() => _AnimatedPatternBuilderState();
}

class _AnimatedPatternBuilderState extends State<AnimatedPatternBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animationValue;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  _initializeController() {
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.durationInMS),
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
      reverseCurve: widget.reverseCurve,
    );

    animationValue = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    Future.delayed(Duration(milliseconds: widget.initialDelayInMS)).then((t) {
      if (widget.repeat) {
        _controller.repeat(reverse: widget.reverse);
      } else {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return widget.patterBuiilder(animationValue.value);
      },
    );
  }
}
