package co.com.merakidevelop.mobile_window_features;

import android.app.Activity;
import android.os.Build;
import android.view.WindowManager;

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

  @SuppressWarnings("unused")
  public MobileWindowFeaturesPlugin() { }

  private MobileWindowFeaturesPlugin(Activity activity) {
    this.activity = activity;
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "mobile_window_features");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (activity == null) {
      result.error("MobileWindowFeaturesPlugin", "MobileWindowFeaturesPlugin: ignored flag state change, current activity is null", null);
    }

    switch (call.method) {
      case "addFlags":
        final int addFlags = call.argument("flags");
        if (!validLayoutParams(result, addFlags)) {
          return;
        }
        activity.getWindow().addFlags(addFlags);
        result.success(true);
        break;
      case "clearFlags":
        final int clearFlags = call.argument("flags");
        if (!validLayoutParams(result, clearFlags)) {
          return;
        }
        activity.getWindow().clearFlags(clearFlags);
        result.success(true);
        break;
      case "setFlags":
        final int setFlags = call.argument("flags");
        final int maskFlags = call.argument("mask");
        if (!validLayoutParams(result, setFlags)) {
          return;
        }
        if (!validLayoutParams(result, maskFlags)) {
          return;
        }
        activity.getWindow().setFlags(setFlags, maskFlags);
        result.success(true);
        break;
      case "setDecorFitsSystemWindows":
        final boolean decorFitsSystemWindows = call.argument("decorFitsSystemWindows");
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
          activity.getWindow().setDecorFitsSystemWindows(decorFitsSystemWindows);
        }
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
  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding activityPluginBinding) {
    onAttachedToActivity(activityPluginBinding);
  }

  @Override
  public void onDetachedFromActivity() {
    activity = null;
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity();
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
      if ((flags & flag) == 1) {
        if (!validLayoutParam(flag)) {
          result.error("MobileWindowFeaturesPlugin","MobileWindowFeaturesPlugin: invalid flag specification: " + Integer.toHexString(flag), null);
          return false;
        }
      }
    }
    return true;
  }
}
