import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_window_features/mobile_window_features.dart';
import 'package:mobile_window_features/mobile_window_features_platform_interface.dart';
import 'package:mobile_window_features/mobile_window_features_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMobileWindowFeaturesPlatform
    with MockPlatformInterfaceMixin
    implements MobileWindowFeaturesPlatform {
  @override
  Future<bool?> addFlags(int flags) {
    // TODO: implement addFlags
    throw UnimplementedError();
  }

  @override
  Future<bool?> clearFlags(int flags) {
    // TODO: implement clearFlags
    throw UnimplementedError();
  }

  @override
  Future<bool?> setDecorFitsSystemWindows(bool decorFitsSystemWindows) {
    // TODO: implement setDecorFitsSystemWindows
    throw UnimplementedError();
  }

  @override
  Future<bool?> setFlags(int flags, int mask) {
    // TODO: implement setFlags
    throw UnimplementedError();
  }

  //@override
  //Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MobileWindowFeaturesPlatform initialPlatform =
      MobileWindowFeaturesPlatform.instance;

  test('$MethodChannelMobileWindowFeatures is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMobileWindowFeatures>());
  });

  test('getPlatformVersion', () async {
    MobileWindowFeatures mobileWindowFeaturesPlugin = MobileWindowFeatures();
    MockMobileWindowFeaturesPlatform fakePlatform =
        MockMobileWindowFeaturesPlatform();
    MobileWindowFeaturesPlatform.instance = fakePlatform;

    //expect(await mobileWindowFeaturesPlugin.getPlatformVersion(), '42');
  });
}
