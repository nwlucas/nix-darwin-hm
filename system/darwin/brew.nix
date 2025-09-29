{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    caskArgs = {
      fontdir = "~/Library/Fonts";
    };

    brews = [ ];

    casks = [ ];

    taps = [ ];
  };
}
