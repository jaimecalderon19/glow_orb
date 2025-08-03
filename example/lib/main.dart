import 'package:flutter/material.dart';
import 'package:glow_orb/glow_orb.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glow Orb Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Glow Orb Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<Color> currentOrbColors = GlowOrbThemes.rainbow;
  
  void _changeOrbTheme() {
    setState(() {
      if (currentOrbColors == GlowOrbThemes.rainbow) {
        currentOrbColors = GlowOrbThemes.sunset;
      } else if (currentOrbColors == GlowOrbThemes.sunset) {
        currentOrbColors = GlowOrbThemes.ocean;
      } else if (currentOrbColors == GlowOrbThemes.ocean) {
        currentOrbColors = GlowOrbThemes.cyber;
      } else if (currentOrbColors == GlowOrbThemes.cyber) {
        currentOrbColors = GlowOrbThemes.professional;
      } else {
        currentOrbColors = GlowOrbThemes.rainbow;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildGlowOrbDemo(),
          _buildCustomizationDemo(),
          _buildVariationsDemo(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.blur_circular),
            label: 'Main Demo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Customization',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: 'Variations',
          ),
        ],
      ),
    );
  }

  Widget _buildGlowOrbDemo() {
    return Stack(
      children: [
        GlowOrb(
          size: 300,
          customColorScheme: currentOrbColors,
          onTap: _changeOrbTheme,
          floatIntensity: 10,
          lookAroundIntensity: 10,
        ),
        Positioned(
          top: 50,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Tap the orb to change color themes!\n\nThis is the GlowOrb widget with multiple animations, color blobs, and customizable parameters.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomizationDemo() {
    return Container(
      color: Colors.grey[900],
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Customization Examples',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildCustomExample(
                  title: "Minimal Setup",
                  widget: const GlowOrb(size: 150),
                  description: "Just specify size, all other parameters are optional",
                ),
                _buildCustomExample(
                  title: "No Animations",
                  widget: const GlowOrb(
                    size: 150,
                    enableFloating: false,
                    enableColorShift: false,
                    enableBlinking: false,
                    enableLookAround: false,
                    enableStartupAnimation: false,
                  ),
                  description: "All animations disabled for static display",
                ),
                _buildCustomExample(
                  title: "Custom Colors",
                  widget: const GlowOrb(
                    size: 150,
                    customColorScheme: [
                      Colors.red,
                      Colors.orange,
                      Colors.yellow,
                    ],
                  ),
                  description: "Using custom color scheme",
                ),
                _buildCustomExample(
                  title: "Fast Animations",
                  widget: const GlowOrb(
                    size: 150,
                    floatAnimationDuration: Duration(seconds: 2),
                    colorShiftDuration: Duration(seconds: 5),
                    blinkDuration: Duration(seconds: 1),
                  ),
                  description: "Faster animation speeds",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomExample({
    required String title,
    required Widget widget,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: Center(child: widget),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildVariationsDemo() {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Size & Theme Variations',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              children: const [
                GlowOrb(
                  size: 120,
                  customColorScheme: GlowOrbThemes.sunset,
                ),
                GlowOrb(
                  size: 150,
                  customColorScheme: GlowOrbThemes.ocean,
                ),
                GlowOrb(
                  size: 100,
                  customColorScheme: GlowOrbThemes.cyber,
                ),
                GlowOrb(
                  size: 180,
                  customColorScheme: GlowOrbThemes.professional,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}