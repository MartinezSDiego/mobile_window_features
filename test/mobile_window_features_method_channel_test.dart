import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_window_features/mobile_window_features.dart';
import 'package:mobile_window_features/mobile_window_features_method_channel.dart';
import 'package:mobile_window_features/mobile_window_features_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMobileWindowFeaturesPlatform
    with MockPlatformInterfaceMixin
    implements MobileWindowFeaturesPlatform {
  @override
  Future<bool?> addFlags(int flags) {
    return Future<bool?>.value(true);
  }

  @override
  Future<bool?> clearFlags(int flags) {
    return Future<bool?>.value(true);
  }

  @override
  Future<bool?> setDecorFitsSystemWindows(bool decorFitsSystemWindows) {
    return Future<bool?>.value(true);
  }

  @override
  Future<bool?> setFlags(int flags, int mask) {
    return Future<bool?>.value(true);
  }

  @override
  Future<bool?> setNavigationBarColor(int color) {
    return Future<bool?>.value(true);
  }

  @override
  Future<bool?> setNavigationBarTheme(int navigationBarTheme) {
    return Future<bool?>.value(true);
  }

  @override
  Future<bool?> setScreenLimits(int screenLimits) {
    return Future<bool?>.value(true);
  }

  @override
  Future<bool?> setStatusBarColor(int color) {
    return Future<bool?>.value(true);
  }

  @override
  Future<bool?> setStatusBarTheme(int statusBarTheme) {
    return Future<bool?>.value(true);
  }
}

void main() {
  final MobileWindowFeaturesPlatform initialPlatform =
      MobileWindowFeaturesPlatform.instance;

  test('$MethodChannelMobileWindowFeatures is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMobileWindowFeatures>());
  });
  test('addFlags', () async {
    expect(
        MobileWindowFeatures.addFlags(
          flags: MobileWindowFeatures.flagDrawsSystemBarBackgrounds,
        ),
        true);
  });
}
