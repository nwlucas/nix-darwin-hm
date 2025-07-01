{ user, ... }:
{
  config = {
    system.primaryUser = "nwilliams-lucas";
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
