{ user, ... }:
{
  config = {
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
