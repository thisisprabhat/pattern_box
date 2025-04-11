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
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  final tabs = ['Static', 'Animated'];

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
            (i) => Padding(padding: EdgeInsets.all(8), child: Text(tabs[i])),
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
          ListView.builder(
            itemCount: patternList.length,
            itemBuilder:
                (context, index) => patternBox(context, patternList[index]),
          ),
          //Animated Pattern List
          ListView.builder(
            itemCount: animatedPatternList(context).length,
            itemBuilder:
                (context, index) => animatedPatternList(context)[index],
          ),
        ],
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

  List<Widget> animatedPatternList(context) {
    return [
      AnimatedPatternBuilder(
        repeat: true,
        patterBuiilder: (value) {
          return patternBox(
            context,
            WavePainter(repaint: true, amplitude: 20 * value),
          );
        },
      ),
      // AnimatedPatternBuilder(
      //   repeat: true,
      //   patterBuiilder: (value) {
      //     final scale = 1 + 0.2 * value;
      //     final rotation = value * 3.14;
      //     return Transform.scale(
      //       scale: scale,
      //       child: Transform.rotate(
      //         angle: rotation,
      //         child: patternBox(
      //           context,
      //           WebMatrixPainter(repaint: true, gap: 10 + value * 5),
      //         ),
      //       ),
      //     );
      //   },
      // ),
      // AnimatedPatternBuilder(
      //   repeat: true,
      //   patterBuiilder: (value) {
      //     return patternBox(
      //       context,
      //       StripePattern(repaint: true, gap: 20 * value),
      //     );
      //   },
      // ),
    ];
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
