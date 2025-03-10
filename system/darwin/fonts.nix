{ pkgs, lib, ... }:

{
  # Fonts
  fonts = {
    packages = with pkgs; [
      vistafonts
      corefonts
    ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  };
}
