{ pkgs, ... }:
{
  nix = {
    enable = true;

    package = pkgs.nixVersions.latest;

    settings = {
      trusted-users = [
        "root"
        "@admin"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      download-buffer-size = 134217728; # 128 MiB — prevents buffer-full warnings on large builds
      warn-dirty = false;
    };

    optimise.automatic = true;

    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
      }; # Sundays
      options = "--delete-older-than 30d";
    };
  };
}
