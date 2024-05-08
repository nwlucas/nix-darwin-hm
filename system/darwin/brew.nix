{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };

    brews = [
      "cloudflared"
      "openssl-osx-ca"
    ];

    casks = [
      # https://github.com/NixOS/nixpkgs/issues/254944
      "1password"
      "1password-cli"
      "docker"
      "google-chrome"
      "raycast"
      "scroll-reverser"
      "jetbrains-toolbox"
      "parallels"
      "pandora"
      "postman"
      "slack"
      "teamviewer"
      "zoom"
      "sublime-text"
      "cloudflare-warp"
    ];

    taps = [
      "cloudflare/cloudflare"
      "raggi/ale"
    ];
  };
}
