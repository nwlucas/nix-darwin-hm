{ pkgs, ... }:

{
  imports = [
    ../modules
    ./nix.nix
    ./packages.nix
    ./shells.nix
  ];

  # Localization
  time.timeZone = "America/New_York";
}
