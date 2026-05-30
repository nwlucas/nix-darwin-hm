{ pkgs, user, ... }:
let
  homePrefix = if pkgs.stdenv.isDarwin then "/Users" else "/home";
in
{
  config = {
    d.profiles = {
      base.enable = true;
      dev.enable = true;
      gui-small.enable = true;
      gui-full.enable = false;
      business.enable = false;
      gaming.enable = false;
    };

    ids.gids.nixbld = 30000;
    system.primaryUser = user;

    home-manager = {
      users.${user} = {
        home = {};

        programs = {};
      };
    };
  };
}
