import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mobile_window_features_method_channel.dart';

abstract class MobileWindowFeaturesPlatform extends PlatformInterface {
  /// Constructs a MobileWindowFeaturesPlatform.
  MobileWindowFeaturesPlatform() : super(token: _token);

  static final Object _token = Object();

  static MobileWindowFeaturesPlatform _instance =
      MethodChannelMobileWindowFeatures();

  /// The default instance of [MobileWindowFeaturesPlatform] to use.
  ///
  /// Defaults to [MethodChannelMobileWindowFeatures].
  static MobileWindowFeaturesPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MobileWindowFeaturesPlatform] when
  /// they register themselves.
  static set instance(MobileWindowFeaturesPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> addFlags(int flags);
  Future<bool?> clearFlags(int flags);
  Future<bool?> setFlags(int flags, int mask);
  Future<bool?> setDecorFitsSystemWindows(bool decorFitsSystemWindows);
}
