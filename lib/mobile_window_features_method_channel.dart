import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mobile_window_features_platform_interface.dart';

/// An implementation of [MobileWindowFeaturesPlatform] that uses method channels.
class MethodChannelMobileWindowFeatures extends MobileWindowFeaturesPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel methodChannel =
      const MethodChannel('mobile_window_features');

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

  @override
  Future<bool?> setScreenLimits(int screenLimits) async {
    return await methodChannel.invokeMethod<bool>("setScreenLimits", {
      "screenLimits": screenLimits,
    });
  }

  @override
  Future<bool?> setStatusBarColor(int color) async {
    return await methodChannel.invokeMethod<bool>("setStatusBarColor", {
      "colorInt": color,
    });
  }

  @override
  Future<bool?> setNavigationBarColor(int color) async {
    return await methodChannel.invokeMethod<bool>("setNavigationBarColor", {
      "colorInt": color,
    });
  }

  @override
  Future<bool?> setStatusBarTheme(int statusBarTheme) async {
    return await methodChannel.invokeMethod<bool>("setStatusBarTheme", {
      "statusBarTheme": statusBarTheme,
    });
  }

  @override
  Future<bool?> setNavigationBarTheme(int navigationBarTheme) async {
    return await methodChannel.invokeMethod<bool>("setNavigationBarTheme", {
      "navigationBarTheme": navigationBarTheme,
    });
  }
}
