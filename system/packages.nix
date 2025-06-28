{
  pkgs,
  lib,
  inputs,
  ...
}:

let
  pkgs-unstable = import inputs.nixpkgs {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
in

{
  environment.systemPackages =
    with pkgs;
    [
      #wezterm
      # Utils
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
      nixd
      tree
      nixfmt-rfc-style
      wezterm

      # From unstable channel
      pkgs-unstable.biome
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
