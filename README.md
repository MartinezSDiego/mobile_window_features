# mobile_window_features
![GitHub License](https://img.shields.io/github/license/MartinezSDiego/mobile_window_features?label=License&color=blue&link=https%3A%2F%2Fgithub.com%2FMartinezSDiego%2Fmobile_window_features%3Ftab%3DApache-2.0-1-ov-file%23readme) ![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/MartinezSDiego/mobile_window_features?label=Issues&link=https%3A%2F%2Fgithub.com%2FMartinezSDiego%2Fmobile_window_features%2Fissues) ![Pub Version](https://img.shields.io/pub/v/mobile_window_features?label=Version&color=green)

This plugin was created to change some necessary configuration in the Android window to draw behind the status bar and the navigation bar.

## Features
- Draw behind the status bar
- Draw behind the navigation bar
- Change Android window flags

## How to use it
<img src="https://merakidevelop.com.co/public-resources/images/mobile_window_features_screenshot_001.jpg" alt="drawing" width="200"/>
```dart
import 'package:mobile_window_features/mobile_window_features.dart';
import 'package:mobile_window_features/status_navigation_bars_options.dart';

class UnboundedPage extends StatelessWidget {
  const UnboundedPage({super.key});

  @override
  Widget build(BuildContext context) {
    MobileWindowFeatures.setScreenProperties(
        screenLimits: ScreenLimits.pageDrawBehindTheStatusBarNavigationBar,
        statusBarColor: Colors.transparent,
        statusBarTheme: StatusBarThemeMWF.darkStatusBar,
        navigationBarColor: Colors.transparent,
        navigationBarTheme: NavigationBarThemeMWF.darkNavigationBar);

    return Scaffold(
	...
	);
  }
```
