import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:mobile_window_features/mobile_window_features.dart';
import 'package:mobile_window_features/status_navigation_bars_options.dart';

class BoundedPage extends StatelessWidget {
  const BoundedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MobileWindowFeatures.setScreenProperties(
        ScreenLimits.pageDrawLimitedByStatusBarNavigationBar,
        Colors.blue,
        StatusBarThemeMWF.darkStatusBar,
        Colors.white,
        NavigationBarThemeMWF.lightNavigationBar);

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
              Color.fromARGB(255, 134, 228, 27),
              Color.fromARGB(255, 33, 228, 98),
              Color.fromARGB(255, 238, 206, 27),
              Color.fromARGB(255, 207, 142, 1),
            ],
            stops: [0.0, 0.4, 0.6, 1.0],
            transform: GradientRotation(305 * math.pi / 180)));
  }
}
