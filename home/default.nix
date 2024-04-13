{ pkgs, lib, user, version, ... }:

let
  homePrefix =
    if pkgs.stdenv.isDarwin
    then "/Users"
    else "/home";
in

{
  imports = [
    ./ssh_config.nix
    ./autostart.nix
    ./eza.nix
    lib.mkIf pkgs.stdenv.isDarwin {
      imports = [
        ./apps
        ./cli
      ];
    }
    lib.mkIf pkgs.stdenv.isLinux {
      imports = [
        ./cli/bat
        ./cli/starship
        ./cli/jq.nix
        ./cli/neovim.nix
      ];
    }
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
