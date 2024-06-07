{ pkgs, ... }:

{
  imports = [
    ../modules
    ./hm.nix
    ./nix.nix
    ./packages.nix
    ./shells.nix
  ];

  # Localization
  time.timeZone = "America/New_York";
  services.tailscale.enable = true;
}
