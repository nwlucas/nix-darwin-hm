{ pkgs, lib, user, version, ... }:

let
  homePrefix =
    if pkgs.stdenv.isDarwin
    then "/Users"
    else "/home";
in

{
  imports = [
    ../shared/cli/bat
    ../shared/cli/starship
    ../shared/cli/jq.nix
    ../shared/cli/neovim.nix
    ../shared/ssh_config.nix
    ../shared/autostart.nix
    ./eza.nix
    # lib.mkIf pkgs.stdenv.isDarwin { imports = [./apps]; }
  ];


  home = {
    username = user;
    homeDirectory = lib.mkForce "${homePrefix}/${user}";
    stateVersion = version;
  };

  xdg.enable = true;
  programs.home-manager.enable = true;
  programs.zsh.enable = true;
  xsession.numlock.enable = pkgs.stdenv.isLinux;
}
