{ pkgs, lib, user, version, ... }:

let
  homePrefix =
    if pkgs.stdenv.isDarwin
    then "/Users"
    else "/home";

  extraImports =
    if pkgs.stdenv.isDarwin
    then [
        ./apps
        ./cli
    ]
    else if pkgs.stdenv.isLinux
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
  ] ++ extraImports;


  home = {
    username = user;
    homeDirectory = lib.mkForce "${homePrefix}/${user}";
    stateVersion = version;
  };

  xdg.enable = true;
  programs.home-manager.enable = true;
  xsession.numlock.enable = pkgs.stdenv.isLinux;
}
