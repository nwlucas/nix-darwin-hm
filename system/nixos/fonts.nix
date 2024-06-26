{ pkgs, ... }:

{
  # Fonts
  fonts = {
    fontDir.enable = true;
    # Renamed to packages in NixOS 23.11 but lacks darwin support:
    # https://github.com/LnL7/nix-darwin/issues/752
    packages = with pkgs; [
      cascadia-code
      hack-font
      fira-code
      fira-code-nerdfont
      jetbrains-mono
      powerline-symbols
      noto-fonts-color-emoji
      nerdfonts
      meslo-lg
      meslo-lgs-nf
      source-code-pro
    ];
  };
}
