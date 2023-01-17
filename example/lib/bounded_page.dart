import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mobile_window_features/mobile_window_features.dart';

class BoundedPage extends StatelessWidget {
  const BoundedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: createBackground(),
      child: Column(children: const [Text("pruebas")]),
    );
  }

  BoxDecoration createBackground() {
    MobileWindowFeatures.clearFlags(MobileWindowFeatures.FLAG_LAYOUT_NO_LIMITS);
    MobileWindowFeatures.setFlags(
        MobileWindowFeatures.FLAG_LAYOUT_IN_SCREEN |
            MobileWindowFeatures.FLAG_LAYOUT_INSET_DECOR,
        MobileWindowFeatures.FLAG_LAYOUT_IN_SCREEN |
            MobileWindowFeatures.FLAG_LAYOUT_INSET_DECOR);
    MobileWindowFeatures.addFlags(
        MobileWindowFeatures.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
    MobileWindowFeatures.clearFlags(
        MobileWindowFeatures.FLAG_TRANSLUCENT_STATUS);
    MobileWindowFeatures.clearFlags(
        MobileWindowFeatures.FLAG_TRANSLUCENT_NAVIGATION);
    MobileWindowFeatures.setDecorFitsSystemWindows(true);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemStatusBarContrastEnforced: true,
      systemNavigationBarContrastEnforced: true,
    ));

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
