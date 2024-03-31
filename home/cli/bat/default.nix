{ pkgs, theme, ... }:

{
  d.shell.aliases = {
    cat = "bat";
    catp = "bat -P";
  };

  programs.bat = {
    enable = true;
    enableZshIntegration = true;
    config = {
      theme = "TwoDark";
      style = "plain";
    };
  };

  home.file.".config/bat/themes" = {
    recursive = true;
    source = ./themes;
    onChange = "${pkgs.bat}/bin/bat cache --build";
  };
}
