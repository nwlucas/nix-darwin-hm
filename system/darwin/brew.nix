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
      "openssl@3"
    ];

    casks = [
      # https://github.com/NixOS/nixpkgs/issues/254944
      "angry-ip-scanner"
      "1password"
      "1password-cli"
      "docker"
      "google-chrome"
      "microsoft-remote-desktop"
      "raycast"
      "scroll-reverser"
      "jetbrains-toolbox"
      "parallels"
      "pandora"
      "postman"
      "slack"
      "tailscale"
      "teamviewer"
      "zoom"
      "sublime-text"
      "cloudflare-warp"
      "temurin"
      "temurin@20"
    ];

    taps = [
      "cloudflare/cloudflare"
      "raggi/ale"
    ];
  };
}
