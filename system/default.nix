{ pkgs, ... }:

{
  imports = [
    ../modules
    ./hm.nix
    ./nix.nix
    ./packages.nix
    ./shells.nix
  ];
  ids.gids.nixbld = 350;

  # Localization
  time.timeZone = "America/New_York";
}
