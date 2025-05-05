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
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

//! Home Screen ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  final tabs = ['Static', 'Animated', 'PatternBox Widget'];

  @override
  Widget build(BuildContext context) {
    final patternList = PatternBox.patternList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        bottom: TabBar(
          controller: _tabController,
          onTap:
              (value) => _pageController.animateToPage(
                value,
                duration: Durations.extralong1,
                curve: Curves.decelerate,
              ),
          tabs: List.generate(
            tabs.length,
            (i) => Padding(
              padding: EdgeInsets.all(8),
              child: Text(tabs[i], textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          _tabController.animateTo(value);
        },
        children: [
          //Static pattern list
          staticPatternList(patternList),
          //Animated Pattern List
          animatedPatterns(context),
          //Customized PatternBox
          customizedPatternBox(),
        ],
      ),
    );
  }

  Padding customizedPatternBox() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: PatternBoxWidget(
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
      ),
    );
  }

  ListView animatedPatterns(BuildContext context) {
    return ListView(
      children: [
        AnimatedPatternBuilder(
          repeat: true,
          patterBuiilder: (value) {
            return patternBox(
              context,
              WavePainter(repaint: true, amplitude: 20 * value),
            );
          },
        ),
      ],
    );
  }

  ListView staticPatternList(List<PatternBox> patternList) {
    return ListView.builder(
      itemCount: patternList.length,
      itemBuilder: (context, index) => patternBox(context, patternList[index]),
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

//! FullScreen Pattern ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
