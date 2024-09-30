import 'dart:io';
import 'dart:ui';

import 'package:mobile_window_features/status_navigation_bars_options.dart';

import 'mobile_window_features_platform_interface.dart';

class MobileWindowFeatures {
  /// Window flag: as long as this window is visible to the user, allow the lock screen to activate while the screen is on.
  static const int flagAllowLockWhileScreenOn = 0x00000001;

  /// Window flag: when set, inverts the input method focusability of the window.
  static const int flagAltFocusableIm = 0x00020000;

  /// Window flag: enable blur behind for this window.
  static const int flagBlurBehind = 0x00000004;

  /// Window flag: everything behind this window will be dimmed.
  static const int flagDimBehind = 0x00000002;

  /// This constant was deprecated in API level 26. Use FLAG_SHOW_WHEN_LOCKED or KeyguardManager#requestDismissKeyguard instead. Since keyguard was dismissed all the time as long as an activity with this flag on its window was focused, keyguard couldn't guard against unintentional touches on the screen, which isn't desired.
  static const int flagDismissKeyguard = 0x00400000;

  /// This constant was deprecated in API level 17. This flag is no longer used.
  static const int flagDither = 0x00001000;

  /// Flag indicating that this Window is responsible for drawing the background for the system bars.
  static const int flagDrawsSystemBarBackgrounds = 0x80000000;

  /// This constant was deprecated in API level 30. This value became API "by accident", and shouldn't be used by 3rd party applications.
  static const int flagForceNotFullscreen = 0x00000800;

  /// This constant was deprecated in API level 30. Use WindowInsetsController#hide(int) with Type#statusBars() instead.
  static const int flagFullscreen = 0x00000400;

  /// Indicates whether this window should be hardware accelerated.
  static const int flagHardwareAccelerated = 0x01000000;

  /// Window flag: intended for windows that will often be used when the user is holding the screen against their face, it will aggressively filter the event stream to prevent unintended presses in this situation that may not be desired for a particular window, when such an event stream is detected, the application will receive a CANCEL motion event to indicate this so applications can handle this accordingly by taking no action on the event until the finger is released.
  static const int flagIgnoreCheekPresses = 0x00008000;

  /// Window flag: as long as this window is visible to the user, keep the device's screen turned on and bright.
  static const int flagKeepScreenOn = 0x00000080;

  /// Window flag: When requesting layout with an attached window, the attached window may overlap with the screen decorations of the parent window such as the navigation bar. By including this flag, the window manager will layout the attached window within the decor frame of the parent window such that it doesn't overlap with screen decorations.
  static const int flagLayoutAttachedInDecor = 0x40000000;

  /// This constant was deprecated in API level 30. Insets will always be delivered to your application.
  static const int flagLayoutInsetDecor = 0x00010000;

  /// Window flag: allow window contents to extend in to the screen's overscan area, if there is one. The window should still correctly position its contents to take the overscan area into account.
  static const int flagLayoutInOverscan = 0x02000000;

  /// Window flag for attached windows: Place the window within the entire screen, ignoring any constraints from the parent window.
  static const int flagLayoutInScreen = 0x00000100;

  /// Window flag: allow window to extend outside of the screen.
  static const int flagLayoutNoLimits = 0x00000200;

  /// Flag for a window in local focus mode.
  static const int flagLocalFocusMode = 0x10000000;

  /// Window flag: this window won't ever get key input focus, so the user can not send key or other button events to it.
  static const int flagNotFocusable = 0x00000008;

  /// Window flag: this window can never receive touch events.
  static const int flagNotTouchable = 0x00000010;

  /// Window flag: even when this window is focusable (its FLAG_NOT_FOCUSABLE is not set), allow any pointer events outside of the window to be sent to the windows behind it.
  static const int flagNotTouchModal = 0x00000020;

  /// Window flag: a special mode where the layout parameters are used to perform scaling of the surface when it is composited to the screen.
  static const int flagScaled = 0x00004000;

  /// Window flag: treat the content of the window as secure, preventing it from appearing in screenshots or from being viewed on non-secure displays.
  static const int flagSecure = 0x00002000;

  /// Window flag: ask that the system wallpaper be shown behind your window.
  static const int flagShowWallpaper = 0x00100000;

  /// Window flag: special flag to let windows be shown when the screen is locked. This will let application windows take precedence over key guard or any other lock screens. Can be used with FLAG_KEEP_SCREEN_ON to turn screen on and display windows directly before showing the key guard window. Can be used with FLAG_DISMISS_KEYGUARD to automatically fully dismisss non-secure keyguards. This flag only applies to the top-most full-screen window.
  static const int flagShowWhenLocked = 0x00080000;

  /// Window flag: when set the window will accept for touch events outside of its bounds to be sent to other windows that also support split touch.
  static const int flagSplitTouch = 0x00800000;

  /// Window flag: when set, if the device is asleep when the touch screen is pressed, you will receive this first touch event. Usually the first touch event is consumed by the system since the user can not see what they are pressing on.
  static const int flagTouchableWhenWaking = 0x00000040;

  /// Window flag: request a translucent navigation bar with minimal system-provided background protection.
  static const int flagTranslucentNavigation = 0x08000000;

  /// Window flag: request a translucent status bar with minimal system-provided background protection.
  static const int flagTranslucentStatus = 0x04000000;

  /// Window flag: when set as a window is being added or made visible, once the window has been shown then the system will poke the power manager's user activity (as if the user had woken up the device) to turn the screen on.
  static const int flagTurnScreenOn = 0x00200000;

  /// Window flag: if you have set FLAG_NOT_TOUCH_MODAL, you can set this flag to receive a single special MotionEvent with the action MotionEvent.ACTION_OUTSIDE for touches that occur outside of your window.
  static const int flagWatchOutsideTouch = 0x00040000;

  /// Adds flags [flags] to the WindowManager.LayoutParams
  static Future<bool?> addFlags({required int flags}) async {
    if (!Platform.isAndroid) return Future.value(true);
    return await MobileWindowFeaturesPlatform.instance.addFlags(flags);
  }

  /// Clears flags [flags] from the WindowManager.LayoutParams
  static Future<bool?> clearFlags({required int flags}) async {
    if (!Platform.isAndroid) return Future.value(true);
    return await MobileWindowFeaturesPlatform.instance.clearFlags(flags);
  }

  /// Set flags [flags] from the WindowManager.LayoutParams
  static Future<bool?> setFlags({required int flags, required int mask}) async {
    if (!Platform.isAndroid) return Future.value(true);
    return await MobileWindowFeaturesPlatform.instance.setFlags(flags, mask);
  }

  /// Set Decor Fits System Windows [decorFitsSystemWindows] from the Window
  static Future<bool?> setDecorFitsSystemWindows(
      {required bool decorFitsSystemWindows}) async {
    if (!Platform.isAndroid) return Future.value(true);
    return await MobileWindowFeaturesPlatform.instance
        .setDecorFitsSystemWindows(decorFitsSystemWindows);
  }

  static Future<bool?> setScreenLimits(
      {required ScreenLimits screenLimits}) async {
    if (!Platform.isAndroid) return Future.value(true);
    return await MobileWindowFeaturesPlatform.instance
        .setScreenLimits(screenLimits.idScreenLimits);
  }

  static Future<bool?> setStatusBarColor({required Color color}) async {
    if (!Platform.isAndroid) return Future.value(true);
    return await MobileWindowFeaturesPlatform.instance
        .setStatusBarColor(color.value);
  }

  static Future<bool?> setNavigationBarColor({required Color color}) async {
    if (!Platform.isAndroid) return Future.value(true);
    return await MobileWindowFeaturesPlatform.instance
        .setNavigationBarColor(color.value);
  }

  static Future<bool?> setStatusBarTheme(
      {required StatusBarThemeMWF statusBarTheme}) async {
    if (!Platform.isAndroid) return Future.value(true);
    return await MobileWindowFeaturesPlatform.instance
        .setStatusBarTheme(statusBarTheme.idStatusBarTheme);
  }

  static Future<bool?> setNavigationBarTheme(
      {required NavigationBarThemeMWF navigationBarTheme}) async {
    if (!Platform.isAndroid) return Future.value(true);
    return await MobileWindowFeaturesPlatform.instance
        .setNavigationBarTheme(navigationBarTheme.idNavigationBarTheme);
  }

  static Future<bool?> setScreenProperties(
      {required ScreenLimits screenLimits,
      required Color statusBarColor,
      required StatusBarThemeMWF statusBarTheme,
      required Color navigationBarColor,
      required NavigationBarThemeMWF navigationBarTheme}) async {
    if (!Platform.isAndroid) return Future.value(true);
    await MobileWindowFeaturesPlatform.instance
        .setScreenLimits(screenLimits.idScreenLimits);
    await MobileWindowFeaturesPlatform.instance
        .setStatusBarColor(statusBarColor.value);
    await MobileWindowFeaturesPlatform.instance
        .setNavigationBarColor(navigationBarColor.value);
    await MobileWindowFeaturesPlatform.instance
        .setStatusBarTheme(statusBarTheme.idStatusBarTheme);
    await MobileWindowFeaturesPlatform.instance
        .setNavigationBarTheme(navigationBarTheme.idNavigationBarTheme);
    return Future.value(true);
  }
}
