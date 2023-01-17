import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mobile_window_features/mobile_window_features.dart';

import 'bounded_page.dart';

class UnboundedPage extends StatelessWidget {
  const UnboundedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: createBackground(),
      child: Column(children: [
        const Text("pruebas"),
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
    );
  }

  BoxDecoration createBackground() {
    /*MobileWindowFeatures.setFlags(MobileWindowFeatures.FLAG_LAYOUT_NO_LIMITS,
        MobileWindowFeatures.FLAG_LAYOUT_NO_LIMITS);
    MobileWindowFeatures.addFlags(
        MobileWindowFeatures.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
    MobileWindowFeatures.clearFlags(
        MobileWindowFeatures.FLAG_TRANSLUCENT_STATUS);
    MobileWindowFeatures.clearFlags(
        MobileWindowFeatures.FLAG_TRANSLUCENT_NAVIGATION);
    MobileWindowFeatures.setDecorFitsSystemWindows(true);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemStatusBarContrastEnforced: true,
      systemNavigationBarContrastEnforced: true,
    ));*/

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
