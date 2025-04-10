import 'package:pattern_box/pattern_box.dart';
import 'package:flutter/material.dart';

void main() => runApp(const PatternBoxApp());

class PatternBoxApp extends StatelessWidget {
  const PatternBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pattern Box',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final patternList = PatternBox.patternList;
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: ListView.builder(
        itemCount: patternList.length,
        itemBuilder:
            (context, index) => patternBox(context, patternList[index]),
      ),
    );
  }

  InkWell patternBox(BuildContext context, PatternBox pattern) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenPattern(patternBox: pattern),
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
                  painter: pattern,
                  child: SizedBox(height: 200, width: double.maxFinite),
                ),
              ),
              Divider(height: 30),
              Text(
                pattern.patternName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
