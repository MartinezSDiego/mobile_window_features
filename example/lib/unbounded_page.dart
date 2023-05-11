import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:mobile_window_features/mobile_window_features.dart';
import 'package:mobile_window_features/status_navigation_bars_options.dart';

import 'bounded_page.dart';

class UnboundedPage extends StatelessWidget {
  const UnboundedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MobileWindowFeatures.setScreenProperties(
        ScreenLimits.pageDrawBehindTheStatusBarNavigationBar,
        Colors.transparent,
        StatusBarThemeMWF.darkStatusBar,
        Colors.transparent,
        NavigationBarThemeMWF.darkNavigationBar);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: createBackground(),
          ),
          Column(children: [
            Row(
              children: const [
                Expanded(
                    child: Text(
                  "Test",
                  style: TextStyle(color: Colors.white, fontSize: 40),
                  textAlign: TextAlign.center,
                ))
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BoundedPage()),
                );
              },
              child: const Text("Go BoundedPage"),
            )
          ]),
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
