{ pkgs, lib, ... }:

{
  # Fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      # cascadia-code
      # jetbrains-mono
      # powerline-symbols
      # noto-fonts-color-emoji
      # meslo-lg
      # meslo-lgs-nf
      # source-code-pro
    ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  };
}
