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

    brews = [
      "cloudflared"
      "openssl@3"
      "k9s"
      "Azure/kubelogin/kubelogin"
      "opentofu"
      "pgroll"
      "derailed/k9s/k9s"
      "python3"
      "pipx"
      "ansible"
      "ansible-lint"
      "doctl"
      "kubectl"
      "helm"
    ];

    casks = [
      # https://github.com/NixOS/nixpkgs/issues/254944
      "angry-ip-scanner"
      "1password"
      "1password-cli"
      "cyberduck"
      "google-chrome"
      "microsoft-remote-desktop"
      "raycast"
      "scroll-reverser"
      "jetbrains-toolbox"
      "parallels"
      "pandora"
      "postman"
      "slack"
      "tailscale-app"
      "teamviewer"
      "zoom"
      "sublime-text"
      "cloudflare-warp"
      "temurin"
      "temurin@20"
      "iterm2"
      "orbstack"
      "wezterm"
      "zed"
    ];

    taps = [
      "cloudflare/cloudflare"
      "raggi/ale"
      "xataio/pgroll"
      "derailed/k9s"
      "Azure/kubelogin"
    ];
  };
}
