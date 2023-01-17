import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:mobile_window_features/mobile_window_features.dart';
import 'package:mobile_window_features_example/bounded_page.dart';

import 'unbounded_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
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

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UnboundedPage(),
    );
  }
}
