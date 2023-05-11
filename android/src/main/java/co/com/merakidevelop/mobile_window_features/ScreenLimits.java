package co.com.merakidevelop.mobile_window_features;

public enum ScreenLimits {
    PAGE_DRAW_LIMITED_BY_STATUS_BAR_NAVIGATION_BAR(1),
    PAGE_DRAW_BEHIND_THE_STATUS_BAR_NAVIGATION_BAR(2),
    PAGE_DRAW_WITHOUT_STATUS_BAR_NAVIGATION_BAR(3),
    PAGE_DRAW_WITHOUT_STATUS_BAR(4);

    public final int idScreenLimits;

    private ScreenLimits(int idScreenLimits) {
        this.idScreenLimits = idScreenLimits;
    }

    public static ScreenLimits getScreenLimitsFromId(int idScreenLimits) {
        switch (idScreenLimits) {
          case 1:
            return PAGE_DRAW_LIMITED_BY_STATUS_BAR_NAVIGATION_BAR;
          case 2:
            return PAGE_DRAW_BEHIND_THE_STATUS_BAR_NAVIGATION_BAR;
          case 3:
            return PAGE_DRAW_WITHOUT_STATUS_BAR_NAVIGATION_BAR;
          case 4:
            return PAGE_DRAW_WITHOUT_STATUS_BAR;
          default:
            return PAGE_DRAW_LIMITED_BY_STATUS_BAR_NAVIGATION_BAR;
        }
    }
}