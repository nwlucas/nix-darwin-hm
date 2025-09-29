{
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages =
    with pkgs;
    [
      # from system/packages.nix
      act
      cmake
      coreutils
      curl
      fzf
      gnumake
      httpie
      killall
      lsof
      neofetch
      ripgrep
      unzip
      bat
      vim
      zoxide
      jq
      yq-go
      btop
      cheat
      just
      rustup
      direnv
      starship
      atuin
      p7zip.out
      libisoburn
      sops
      age
      ssh-to-age
      tree
      nixfmt-rfc-style
      gnupg
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  # Add home-manager configurations for CLI tools to the list of hm modules
  d.hm = [
    ../../home/cli
  ];

  homebrew = {
    brews = [
      "cloudflared"
      "openssl@3"
      "1password-cli"
    ];
    taps = [
      "cloudflare/cloudflare"
    ];
  };
}
