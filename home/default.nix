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
    ./apps
    ./cli
  ];

  home.file."Cloudflare_CA.pem".source = ../files/certs/certificate.pem;
  home.file.".curlrc".source = ../files/.curlrc;
  home.file.".ssh/id_ed25519".source = ../files/personal.pub;
  home.file.".ssh/glab-work".source = ../files/glab-work.pub;

  home = {
    username = user;
    homeDirectory = lib.mkForce "${homePrefix}/${user}";
    stateVersion = version;

    sessionVariables = {
      HOMEBREW_BAT = "1";
      HOMEBREW_CURLRC = "1";
    };

    sessionPath = [
      "${homePrefix}/${user}/.local/bin"
    ];
  };

  xdg.enable = true;
  programs.home-manager.enable = true;
  xsession.numlock.enable = pkgs.stdenv.isLinux;
}
