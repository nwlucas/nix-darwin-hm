{
  pkgs,
  lib,
  config,
  ...
}:

{
  config = lib.mkIf config.d.profiles.gui-small.enable {
    environment.systemPackages = with pkgs; [
      mtr-gui
    ];

    homebrew = {
      casks = [
        "iterm2"
        "sublime-text"
      ];
    };
  };
}
