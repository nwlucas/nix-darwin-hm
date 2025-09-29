{ pkgs, ... }:

{
  d.hm = [
    ../../home/apps/1password.nix
  ];

  environment.systemPackages = with pkgs; [
    mtr-gui
  ];

  homebrew = {
    casks = [
      "1password"
    ];
  };
}
