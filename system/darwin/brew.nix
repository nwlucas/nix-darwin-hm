{
  homebrew = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
    caskArgs = {
      fontdir = "~/Library/Fonts";
    };

    brews = [ ];

    casks = [ ];

    taps = [ ];
  };
}
