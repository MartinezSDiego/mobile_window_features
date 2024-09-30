import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mobile_window_features/mobile_window_features.dart';
import 'package:mobile_window_features/status_navigation_bars_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UnboundedPage(),
    );
  }
}

class BoundedPage extends StatelessWidget {
  const BoundedPage({super.key});

  @override
  Widget build(BuildContext context) {
    MobileWindowFeatures.setScreenProperties(
        screenLimits: ScreenLimits.pageDrawLimitedByStatusBarNavigationBar,
        statusBarColor: Colors.blue,
        statusBarTheme: StatusBarThemeMWF.darkStatusBar,
        navigationBarColor: Colors.white,
        navigationBarTheme: NavigationBarThemeMWF.lightNavigationBar);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: createBackground(),
          ),
          const Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                    child: Text(
                      "Test",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                      textAlign: TextAlign.start,
                    ),
                  ))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration createBackground() {
    return const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 134, 228, 27),
              Color.fromARGB(255, 33, 228, 98),
              Color.fromARGB(255, 238, 206, 27),
              Color.fromARGB(255, 207, 142, 1),
            ],
            stops: [0.0, 0.4, 0.6, 1.0],
            transform: GradientRotation(305 * math.pi / 180)));
  }
}

class UnboundedPage extends StatelessWidget {
  const UnboundedPage({super.key});

  @override
  Widget build(BuildContext context) {
    MobileWindowFeatures.setScreenProperties(
        screenLimits: ScreenLimits.pageDrawBehindTheStatusBarNavigationBar,
        statusBarColor: Colors.transparent,
        statusBarTheme: StatusBarThemeMWF.darkStatusBar,
        navigationBarColor: Colors.transparent,
        navigationBarTheme: NavigationBarThemeMWF.darkNavigationBar);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: createBackground(),
          ),
          Column(
            children: [
              const Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                      child: Text(
                        "Test",
                        style: TextStyle(color: Colors.red, fontSize: 40),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  )
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BoundedPage()),
                  );
                },
                child: const Text("Go BoundedPage"),
              )
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration createBackground() {
    return const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 8, 25, 49),
              Color.fromARGB(255, 11, 47, 98),
              Color.fromARGB(255, 36, 69, 114),
              Color.fromARGB(255, 31, 69, 123),
            ],
            stops: [0.0, 0.4, 0.6, 1.0],
            transform: GradientRotation(305 * math.pi / 180)));
  }
}
