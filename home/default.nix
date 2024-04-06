{ pkgs, lib, user, version, ... }:

let
  homePrefix =
    if pkgs.stdenv.isDarwin
    then "/Users"
    else "/home";
in

{
  imports = [
    ./apps
    ./cli
    ./ssh_config.nix
    ./autostart.nix
    # lib.mkIf pkgs.stdenv.isDarwin { imports = [./apps]; }
  ];


  home = {
    username = user;
    homeDirectory = lib.mkForce "${homePrefix}/${user}";
    stateVersion = version;
  };

  xdg.enable = true;
  programs.home-manager.enable = true;
  xsession.numlock.enable = pkgs.stdenv.isLinux;
}
