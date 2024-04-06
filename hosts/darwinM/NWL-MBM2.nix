{ config, user, ... }:
{
    config.home-manager.users.${user}.programs = {
      ssh = {
        matchBlocks = {
          sshRPINWLNEXUS = {
            host          = "rpi-*.nwlnexus.net";
            hostname      = "%h";
            user          = user;
          };
        };
      };
    };
}
