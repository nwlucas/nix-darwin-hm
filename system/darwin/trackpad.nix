{
  system.defaults.trackpad = {
    # Whether to enable trackpad tap to click. The default is false.
    Clicking = true;

    # Whether to enable tap-to-drag. The default is false.
    Dragging = false;

    # Whether to enable three finger drag. The default is false.
    TrackpadThreeFingerDrag = false;
  };

  system.defaults.NSGlobalDomain = {
    # Configures the trackpad tracking speed (0 to 3). The default is
    # “1”.
    "com.apple.trackpad.scaling" = 0.8;
    "com.apple.mouse.tapBehavior" = 1;
    # Whether to enable “Natural” scrolling direction. The default is
    # true.
    "com.apple.swipescrolldirection" = true;

    # When to show the scrollbars. Options are:
    # - WhenScrolling
    # - Automatic
    # - Always
    AppleShowScrollBars = "WhenScrolling";
  };
}
