package co.com.merakidevelop.mobile_window_features;

public enum StatusBarTheme {
    LIGHT_STATUS_BAR(1),
    DARK_STATUS_BAR(2),
    FULL_SCREEN_STATUS_BAR_LIGHT(3),
    FULL_SCREEN_STATUS_BAR_DARK(4);

    public final int idStatusBarTheme;

    private StatusBarTheme(int idStatusBarTheme) {
        this.idStatusBarTheme = idStatusBarTheme;
    }

    public static StatusBarTheme getStatusBarThemeFromId(int idStatusBarTheme) {
        switch (idStatusBarTheme) {
          case 1:
            return LIGHT_STATUS_BAR;
          case 2:
            return DARK_STATUS_BAR;
          case 3:
            return FULL_SCREEN_STATUS_BAR_LIGHT;
          case 4:
            return FULL_SCREEN_STATUS_BAR_DARK;
          default:
            return LIGHT_STATUS_BAR;
        }
    }
}