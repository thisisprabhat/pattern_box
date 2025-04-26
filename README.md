# 🎨 pattern_box

**pattern_box** is a Flutter package packed with a collection of eye-catching **custom painter-based patterns** — perfect for backgrounds, decorations, and dynamic UI elements.

---

## 🚀 Features

- 🧩 15+ built-in pattern painters
- 🎯 Customizable properties like color, gap, thickness, and alignment
- 🖼️ Easy integration with `CustomPaint`
- 🧪 Example app included with previews
- 📦 Lightweight and ready for production use

---

## 📦 Available Patterns

Here’s the current collection of prebuilt patterns:

| Pattern Name                | Description                        |
|----------------------------|------------------------------------|
| `StripePattern`            | Horizontal, vertical, diagonal stripes |
| `HoneyCombPainter`         | Classic beehive hexagon grid       |
| `ConcentricCircleWavePainter` | Radiating circle waves           |
| `ConcentricDottedCirclePainter` | Dotted radial symmetry         |
| `ConcentricPolygonPainter` | Polygons growing outward           |
| `ConcentricCirclePainter`  | Simple concentric circle rings     |
| `WavePainter`              | Smooth sine-style wave patterns    |
| `DottedWavePainter`        | Wavy paths made from dots          |
| `DotsPainter`              | Grid of dots                       |
| `DiamondPainter`           | Criss-crossing diamond pattern     |
| `GridPainter`              | Square tile grid                   |
| `CheckerboxPainter`        | Classic checkerboard               |
| `PlusPainter`              | Repeating plus (+) signs           |
| `CircularPainter`          | Magic Circular Pattern             |
| `WebMatrixPainter`         | Geometric net-like web pattern     |
| `MossaicPainter`           | Mossaic Pattern with different shades|
| `IsomatricGrid`            | Isomatric grid Pattern outline     |
| `IsomatricGrid3D`          | Isomatric grid 3D Pattern with depth effect|
| `StarsPainter`             | Random sized stars with random colors and position|
| `KaleidoscopePainter`      | Symmetrical, kaleidoscope-like patterns with vibrant colors and intricate designs |

---

## For AnimatedPatterns
- We need to wrap patterns with AnimatedPatternBuilder
- And set `repaint=true` inside pattern

```dart
AnimatedPatternBuilder(
        repeat: true,
        patterBuiilder: (value) {
          final scale = 1 + 0.2 * value;
          final rotation = value * 3.14;
          return Transform.scale(
            scale: scale,
            child: Transform.rotate(
              angle: rotation,
              child: patternBox(
                context,
                WebMatrixPainter(repaint: true, gap: 10 + value * 5),
              ),
            ),
          );
        },
      ),
```

## PatternBoxWidget
- We can use pattern out of the box with this widget
- We can customize its appeareance

```dart
PatternBoxWidget(
  pattern: WavePainter(),
  patternGradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.blue, Colors.white, Colors.transparent],
    stops: [0.2, 0.5, 0.8],
  ),
  border: Border.all(color: Colors.white),
  borderRadius: BorderRadius.circular(44),
  backgroundGradient: LinearGradient(
    colors: [Colors.black, Colors.blueGrey],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
)
```

## 🧪 Example App

This package includes a sample app to preview all patterns.

Run it with:

```bash
flutter pub get
flutter run --example
