{ config, pkgs, lib, ... }:

{
  d.hm = [
    ../../home/apps/1password.nix
  ];

  environment.systemPackages = with pkgs; [
    mtr-gui
  ];
}

