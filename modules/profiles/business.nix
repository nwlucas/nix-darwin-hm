{ config, lib, ... }:

{
  config = lib.mkIf config.d.profiles.business.enable {
    homebrew = {
      casks = [
        "slack"
        "teamviewer"
        "zoom"
      ];
    };
  };
}
