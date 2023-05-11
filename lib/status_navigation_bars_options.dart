enum ScreenLimits {
  pageDrawLimitedByStatusBarNavigationBar,
  pageDrawBehindTheStatusBarNavigationBar,
  pageDrawWithoutStatusBarNavigationBar,
  pageDrawWithoutStatusBar,
}

extension ScreenLimitsExtension on ScreenLimits {
  int get idScreenLimits {
    switch (this) {
      case ScreenLimits.pageDrawLimitedByStatusBarNavigationBar:
        return 1;
      case ScreenLimits.pageDrawBehindTheStatusBarNavigationBar:
        return 2;
      case ScreenLimits.pageDrawWithoutStatusBarNavigationBar:
        return 3;
      case ScreenLimits.pageDrawWithoutStatusBar:
        return 4;
    }
  }
}

enum StatusBarThemeMWF {
  lightStatusBar,
  darkStatusBar,
  fullScreenStatusBarLight,
  fullScreenStatusBarDark,
}

extension StatusBarThemeExtension on StatusBarThemeMWF {
  int get idStatusBarTheme {
    switch (this) {
      case StatusBarThemeMWF.lightStatusBar:
        return 1;
      case StatusBarThemeMWF.darkStatusBar:
        return 2;
      case StatusBarThemeMWF.fullScreenStatusBarLight:
        return 3;
      case StatusBarThemeMWF.fullScreenStatusBarDark:
        return 4;
    }
  }
}

enum NavigationBarThemeMWF {
  lightNavigationBar,
  darkNavigationBar,
  fullScreenLightNavigation,
  fullScreenDarkNavigation,
  fullScreenHideNavigation,
}

extension NavigationBarThemeExtension on NavigationBarThemeMWF {
  int get idNavigationBarTheme {
    switch (this) {
      case NavigationBarThemeMWF.lightNavigationBar:
        return 1;
      case NavigationBarThemeMWF.darkNavigationBar:
        return 2;
      case NavigationBarThemeMWF.fullScreenLightNavigation:
        return 3;
      case NavigationBarThemeMWF.fullScreenDarkNavigation:
        return 4;
      case NavigationBarThemeMWF.fullScreenHideNavigation:
        return 5;
    }
  }
}
