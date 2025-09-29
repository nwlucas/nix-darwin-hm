{ user, ... }:
{
  config = {

    d.profiles = {
      base.enable = true;
      dev.enable = true;
      gui-small.enable = true;
      gui-full.enable = true;
      business.enable = true;
      gaming.enable = true;
    };

    ids.gids.nixbld = 350;
    system.primaryUser = user;

    home-manager = {
      users.${user} = {
        programs = {
          ssh = {
            matchBlocks = {
              sshNaraka = {
                host = "naraka.local";
                hostname = "10.98.0.30";
                user = user;
              };
            };
          };
        };
      };
    };
  };
}
