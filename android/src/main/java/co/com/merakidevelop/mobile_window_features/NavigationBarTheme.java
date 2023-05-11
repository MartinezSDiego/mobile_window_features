package co.com.merakidevelop.mobile_window_features;

public enum NavigationBarTheme {
    LIGHT_NAVIGATION_BAR(1),
    DARK_NAVIGATION_BAR(2),
    FULL_SCREEN_LIGHT_NAVIGATION(3),
    FULL_SCREEN_DARK_NAVIGATION(4),
    FULL_SCREEN_HIDE_NAVIGATION(5);

    public final int idNavigationBarTheme;

    private NavigationBarTheme(int idNavigationBarTheme) {
        this.idNavigationBarTheme = idNavigationBarTheme;
    }

    public static NavigationBarTheme getNavigationBarThemeFromId(int idNavigationBarTheme) {
        switch (idNavigationBarTheme) {
          case 1:
            return LIGHT_NAVIGATION_BAR;
          case 2:
            return DARK_NAVIGATION_BAR;
          case 3:
            return FULL_SCREEN_LIGHT_NAVIGATION;
          case 4:
            return FULL_SCREEN_DARK_NAVIGATION;
          case 5:
            return FULL_SCREEN_HIDE_NAVIGATION;
          default:
            return LIGHT_NAVIGATION_BAR;
        }
    }
}