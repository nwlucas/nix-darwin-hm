{ pkgs, theme, ... }:

{
  d.shell.aliases = {
    cat = "bat -P";
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      style = "numbers,changes,header";
    };
  };

  home.file.".config/bat/themes" = {
    recursive = true;
    source = ./themes;
    onChange = "${pkgs.bat}/bin/bat cache --build";
  };
}
