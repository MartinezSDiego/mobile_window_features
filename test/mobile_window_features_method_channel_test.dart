import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_window_features/mobile_window_features.dart';
import 'package:mobile_window_features/mobile_window_features_method_channel.dart';

void main() {
  MethodChannelMobileWindowFeatures platform =
      MethodChannelMobileWindowFeatures();
  const MethodChannel channel = MethodChannel('mobile_window_features');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return true;
    });
    //intentionally let empty
  });

  tearDown(() {
    //intentionally let empty
  });

  test('addFlags', () async {
    expect(
        await platform
            .addFlags(MobileWindowFeatures.flagDrawsSystemBarBackgrounds),
        true);
  });
}
