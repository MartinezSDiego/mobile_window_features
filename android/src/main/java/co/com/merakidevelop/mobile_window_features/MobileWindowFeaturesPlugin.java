package co.com.merakidevelop.mobile_window_features;

import android.app.Activity;
import android.os.Build;
import android.view.WindowManager;
import android.view.Window;
import android.graphics.Color;
import android.view.View;
import android.view.WindowInsetsController;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** MobileWindowFeaturesPlugin */
public class MobileWindowFeaturesPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Activity activity;
  private Window window;

  private static final String FLAGS_PARAMETER = "flags";

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "mobile_window_features");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (activity == null) {
      result.error("MobileWindowFeaturesPlugin", "MobileWindowFeaturesPlugin: ignored flag state change, current activity is null", null);
      return;
    }

    switch (call.method) {
      case "addFlags":
        final int addFlagsInt = getIntParameter(call, FLAGS_PARAMETER);
        if (!validLayoutParams(result, addFlagsInt)) {
          return;
        }
        window.addFlags(addFlagsInt);
        result.success(true);
        break;
      case "clearFlags":
        final int clearFlags = getIntParameter(call, FLAGS_PARAMETER);
        if (!validLayoutParams(result, clearFlags)) {
          return;
        }
        window.clearFlags(clearFlags);
        result.success(true);
        break;
      case "setFlags":
        final int setFlags = getIntParameter(call, FLAGS_PARAMETER);
        final int maskFlags = getIntParameter(call, "mask");
        if (!validLayoutParams(result, setFlags)) {
          return;
        }
        if (!validLayoutParams(result, maskFlags)) {
          return;
        }
        window.setFlags(setFlags, maskFlags);
        result.success(true);
        break;
      case "setDecorFitsSystemWindows":
        final boolean decorFitsSystemWindows = call.argument("decorFitsSystemWindows");
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
          window.setDecorFitsSystemWindows(decorFitsSystemWindows);
        }
        result.success(true);
        break;
      case "setScreenLimits":
        final int screenLimitsParameter = getIntParameter(call, "screenLimits");
        setScreenLimits(ScreenLimits.getScreenLimitsFromId(screenLimitsParameter));
        result.success(true);
        break;
      case "setStatusBarColor":
        final int colorIntStatusBar = getIntParameter(call, "colorInt");
        setStatusBarColor(colorIntStatusBar);
        result.success(true);
        break;
      case "setNavigationBarColor":
        final int colorIntNavigationBar = getIntParameter(call, "colorInt");
        setNavigationBarColor(colorIntNavigationBar);
        result.success(true);
        break;
      case "setStatusBarTheme":
        final int statusBarThemeParameter = getIntParameter(call, "statusBarTheme");
        setStatusBarTheme(StatusBarTheme.getStatusBarThemeFromId(statusBarThemeParameter));
        result.success(true);
        break;
      case "setNavigationBarTheme":
        final int navigationBarThemeParameter = getIntParameter(call, "navigationBarTheme");
        setNavigationBarTheme(NavigationBarTheme.getNavigationBarThemeFromId(navigationBarThemeParameter));
        result.success(true);
        break;
      default:
        result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
    activity = activityPluginBinding.getActivity();
    window = activity.getWindow();
  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding activityPluginBinding) {
    onAttachedToActivity(activityPluginBinding);
  }

  @Override
  public void onDetachedFromActivity() {
    activity = null;
    window = null;
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity();
  }

  private int getIntParameter(@NonNull MethodCall call, String keyParameter) {
    int parameterValue;
    try {
      parameterValue = call.argument(keyParameter);
    } catch (Exception e) {
      long parameterValueLong = call.argument(keyParameter);
      parameterValue = (int) parameterValueLong;
    }
    return parameterValue;
  }
  
  /**
   * Validate flag specification against WindowManager.LayoutParams and API levels, as per:
   * https://developer.android.com/reference/android/view/WindowManager.LayoutParams
   */
  @SuppressWarnings("deprecation")
  private boolean validLayoutParam(int flag) {
    if (Build.VERSION.SDK_INT < 19) {
      return false;
    }
    switch (flag) {
      case WindowManager.LayoutParams.FLAG_ALLOW_LOCK_WHILE_SCREEN_ON:
      case WindowManager.LayoutParams.FLAG_ALT_FOCUSABLE_IM:
      case WindowManager.LayoutParams.FLAG_DIM_BEHIND:
      case WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED:
      case WindowManager.LayoutParams.FLAG_IGNORE_CHEEK_PRESSES:
      case WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON:
      case WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN:
      case WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS:
      case WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE:
      case WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE:
      case WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL:
      case WindowManager.LayoutParams.FLAG_SCALED:
      case WindowManager.LayoutParams.FLAG_SECURE:
      case WindowManager.LayoutParams.FLAG_SHOW_WALLPAPER:
      case WindowManager.LayoutParams.FLAG_SPLIT_TOUCH:
      case WindowManager.LayoutParams.FLAG_WATCH_OUTSIDE_TOUCH:
      case WindowManager.LayoutParams.FLAG_LOCAL_FOCUS_MODE:
      //case WindowManager.LayoutParams.FLAG_BLUR_BEHIND: deprecated API 15
      //case WindowManager.LayoutParams.FLAG_DITHER: deprecated API 17
        return true;
      case WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD:
        return Build.VERSION.SDK_INT < 26;
      case WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS:
        return Build.VERSION.SDK_INT >= 21;
      case WindowManager.LayoutParams.FLAG_FORCE_NOT_FULLSCREEN:
      case WindowManager.LayoutParams.FLAG_FULLSCREEN:
      case WindowManager.LayoutParams.FLAG_LAYOUT_INSET_DECOR:
      case WindowManager.LayoutParams.FLAG_LAYOUT_IN_OVERSCAN:
      case WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION:
      case WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS:
        return Build.VERSION.SDK_INT < 30;
      case WindowManager.LayoutParams.FLAG_LAYOUT_ATTACHED_IN_DECOR:
        return Build.VERSION.SDK_INT >= 22 && Build.VERSION.SDK_INT < 30;
      case WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED:
      case WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON:
        return Build.VERSION.SDK_INT < 27;
      case WindowManager.LayoutParams.FLAG_TOUCHABLE_WHEN_WAKING:
        return Build.VERSION.SDK_INT < 20;
      default:
        return false;
    }
  }

  private boolean validLayoutParams(Result result, int flags) {
    for (int i = 0; i < Integer.SIZE; i++) {
      int flag = (1 << i);
      if ((flags & flag) == 1
          && !validLayoutParam(flag)) {
        result.error("MobileWindowFeaturesPlugin", "MobileWindowFeaturesPlugin: invalid flag specification: " + Integer.toHexString(flag), null);
        return false;
      }
    }
    return true;
  }

  private void setScreenLimitsLimitedByStatusBarNavigationBar() {
    if (window == null) {
      return;
    }
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P)
    {
      window.getAttributes().layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_DEFAULT;
    }
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
    {
      WindowManager.LayoutParams attributes = window.getAttributes();
      window.clearFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS);
      window.clearFlags(WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN);
      window.setFlags(attributes.flags | WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN | WindowManager.LayoutParams.FLAG_LAYOUT_INSET_DECOR, WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN | WindowManager.LayoutParams.FLAG_LAYOUT_INSET_DECOR);
    }
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R)
    {
      window.setDecorFitsSystemWindows(true);
    }
  }

  private void setScreenLimitsBehindStatusBarNavigationBar()
  {
    if (window == null) {
      return;
    }
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P)
    {
      window.getAttributes().layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_DEFAULT;
    }
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
    {
      WindowManager.LayoutParams attributes = window.getAttributes();
      window.setFlags(attributes.flags | WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS, WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS);
    }
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R)
    {
      window.setDecorFitsSystemWindows(false);
    }
  }

  private void setScreenLimitsDrawBehindStatusBar()
  {
    if (window == null) {
      return;
    }
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P)
    {
      window.getAttributes().layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_DEFAULT;
    }
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
    {
      WindowManager.LayoutParams attributes = window.getAttributes();
      window.setFlags(attributes.flags | WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN, WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN);
    }
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R)
    {
      window.setDecorFitsSystemWindows(false);
    }
  }

  private void setScreenLimits(ScreenLimits screenLimits)
  {
    switch (screenLimits)
    {
      case PAGE_DRAW_LIMITED_BY_STATUS_BAR_NAVIGATION_BAR:
        setScreenLimitsLimitedByStatusBarNavigationBar();
        break;
      case PAGE_DRAW_BEHIND_THE_STATUS_BAR_NAVIGATION_BAR:
        setScreenLimitsBehindStatusBarNavigationBar();
        break;
      case PAGE_DRAW_WITHOUT_STATUS_BAR_NAVIGATION_BAR:
      case PAGE_DRAW_WITHOUT_STATUS_BAR:
        setScreenLimitsDrawBehindStatusBar();
        break;
    }
  }

  private void setStatusBarColor(int colorInt) {
    if (window == null) {
      return;
    }
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP)
    {
      window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
      window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
      window.setStatusBarColor(colorInt);
    }
  }

  private void setNavigationBarColor(int colorInt) {
    if (window == null) {
      return;
    }
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP)
    {
      window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
      window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION);
      window.setNavigationBarColor(colorInt);
    }
  }

  private void setStatusBarTheme(StatusBarTheme statusBarTheme) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
      int options = window.getDecorView().getSystemUiVisibility();
      switch (statusBarTheme) {
          case LIGHT_STATUS_BAR:
              options = View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
              break;
          case DARK_STATUS_BAR:
              options = View.VISIBLE;
              break;
          case FULL_SCREEN_STATUS_BAR_LIGHT:
              options |= View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
              options |= View.SYSTEM_UI_FLAG_IMMERSIVE;
              options |= View.SYSTEM_UI_FLAG_LAYOUT_STABLE;
              options |= View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN;
              options |= View.SYSTEM_UI_FLAG_FULLSCREEN;
              break;
          case FULL_SCREEN_STATUS_BAR_DARK:
              options |= View.VISIBLE;
              options |= View.SYSTEM_UI_FLAG_IMMERSIVE;
              options |= View.SYSTEM_UI_FLAG_LAYOUT_STABLE;
              options |= View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN;
              options |= View.SYSTEM_UI_FLAG_FULLSCREEN;
              break;
      }
      window.getDecorView().setSystemUiVisibility(options);
    }

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
      switch (statusBarTheme) {
          case LIGHT_STATUS_BAR:
          case FULL_SCREEN_STATUS_BAR_LIGHT:
              window.getInsetsController().setSystemBarsAppearance(WindowInsetsController.APPEARANCE_LIGHT_STATUS_BARS, WindowInsetsController.APPEARANCE_LIGHT_STATUS_BARS);
              break;
          case DARK_STATUS_BAR:
          case FULL_SCREEN_STATUS_BAR_DARK:
              window.getInsetsController().setSystemBarsAppearance(0, WindowInsetsController.APPEARANCE_LIGHT_STATUS_BARS);
              break;
      }
    }
  }

  private void setNavigationBarTheme(NavigationBarTheme navigationBarTheme) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
      int options = window.getDecorView().getSystemUiVisibility();
      switch (navigationBarTheme) {
          case LIGHT_NAVIGATION_BAR:
              options |= View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR;
              break;
          case DARK_NAVIGATION_BAR:
              options |= View.VISIBLE;
              break;
          case FULL_SCREEN_LIGHT_NAVIGATION:
              options |= View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR;
              options |= View.SYSTEM_UI_FLAG_IMMERSIVE;
              options |= View.SYSTEM_UI_FLAG_LAYOUT_STABLE;
              options |= View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN;
              options |= View.SYSTEM_UI_FLAG_FULLSCREEN;
              break;
          case FULL_SCREEN_DARK_NAVIGATION:
              options |= View.VISIBLE;
              options |= View.SYSTEM_UI_FLAG_IMMERSIVE;
              options |= View.SYSTEM_UI_FLAG_LAYOUT_STABLE;
              options |= View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN;
              options |= View.SYSTEM_UI_FLAG_FULLSCREEN;
              break;
          case FULL_SCREEN_HIDE_NAVIGATION:
              options |= View.SYSTEM_UI_FLAG_IMMERSIVE;
              options |= View.SYSTEM_UI_FLAG_LAYOUT_STABLE;
              options |= View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION;
              options |= View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN;
              options |= View.SYSTEM_UI_FLAG_HIDE_NAVIGATION;
              options |= View.SYSTEM_UI_FLAG_FULLSCREEN;
              break;
      }
      window.getDecorView().setSystemUiVisibility(options);
    }

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
      switch (navigationBarTheme) {
          case LIGHT_NAVIGATION_BAR:
          case FULL_SCREEN_LIGHT_NAVIGATION:
              window.getInsetsController().setSystemBarsAppearance(WindowInsetsController.APPEARANCE_LIGHT_NAVIGATION_BARS, WindowInsetsController.APPEARANCE_LIGHT_NAVIGATION_BARS);
              break;
          case DARK_NAVIGATION_BAR:
          case FULL_SCREEN_DARK_NAVIGATION:
              window.getInsetsController().setSystemBarsAppearance(0, WindowInsetsController.APPEARANCE_LIGHT_NAVIGATION_BARS);
              break;
          case FULL_SCREEN_HIDE_NAVIGATION:
              window.getInsetsController().setSystemBarsAppearance(0, 0);
              break;
      }
    }
  }
}
