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
      gui-full.enable = true;
      business.enable = true;
      gaming.enable = false;
    };

    ids.gids.nixbld = 350;
    system.primaryUser = "nwilliams-lucas";

    home-manager = {
      users.${user} = {
        home = {};

        programs = {};
      };
    };
  };
}
