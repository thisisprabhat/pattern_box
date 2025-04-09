import 'package:example/full_screen.dart';
import 'package:flutter/material.dart';
import 'package:pattern_box/pattern_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PatternBox> painters = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: ListView.builder(
        itemCount: painters.length,
        itemBuilder: (context, index) => painterCard(painters[index]),
      ),
    );
  }

  InkWell painterCard(PatternBox painter) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenPattern(patternBox: painter),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CustomPaint(
                  painter: painter,
                  child: SizedBox(height: 200, width: double.maxFinite),
                ),
              ),
              Divider(height: 30),
              Text(
                painter.patternName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
