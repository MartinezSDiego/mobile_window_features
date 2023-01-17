import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mobile_window_features_platform_interface.dart';

/// An implementation of [MobileWindowFeaturesPlatform] that uses method channels.
class MethodChannelMobileWindowFeatures extends MobileWindowFeaturesPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mobile_window_features');

  /// Adds flags [flags] to the WindowManager.LayoutParams
  @override
  Future<bool?> addFlags(int flags) async {
    return await methodChannel.invokeMethod<bool>("addFlags", {
      "flags": flags,
    });
  }

  /// Clears flags [flags] from the WindowManager.LayoutParams
  @override
  Future<bool?> clearFlags(int flags) async {
    return await methodChannel.invokeMethod<bool>("clearFlags", {
      "flags": flags,
    });
  }

  /// Set flags [flags] from the WindowManager.LayoutParams
  @override
  Future<bool?> setFlags(int flags, int mask) async {
    return await methodChannel.invokeMethod<bool>("setFlags", {
      "flags": flags,
      "mask": mask,
    });
  }

  /// Set Decor Fits System Windows [decorFitsSystemWindows] from the Window
  @override
  Future<bool?> setDecorFitsSystemWindows(bool decorFitsSystemWindows) async {
    return await methodChannel.invokeMethod<bool>("setDecorFitsSystemWindows", {
      "decorFitsSystemWindows": decorFitsSystemWindows,
    });
  }
}
