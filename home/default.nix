{ pkgs, lib, user, version, ... }:

let
  homePrefix =
    if pkgs.stdenv.isDarwin
    then "/Users"
    else "/home";

  darwinImports =
    if pkgs.stdenv.isDarwin
    then [
        ./apps
        ./cli
    ]
    else [];
  linuxImports =
    if pkgs.stdenv.isLinux
    then [
        ./cli/bat
        ./cli/starship
        ./cli/jq.nix
        ./cli/neovim.nix
    ]
    else [];
in

{
  imports = [
    ./ssh_config.nix
    ./autostart.nix
    ./eza.nix
  ] ++ darwinImports ++ linuxImports;


  home = {
    username = user;
    homeDirectory = lib.mkForce "${homePrefix}/${user}";
    stateVersion = version;
  };

  xdg.enable = true;
  programs.home-manager.enable = true;
  xsession.numlock.enable = pkgs.stdenv.isLinux;
}
