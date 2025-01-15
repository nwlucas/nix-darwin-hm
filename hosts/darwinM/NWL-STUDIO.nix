{ config, user, ... }:
{
  config = {
    home.file.".ssh/id_rpi_ed25519".source = ../files/id_rpi_ed25519.pub;
    home-manager = {
      users.${user}.programs = {
        ssh = {
          matchBlocks = {
            sshRPINWLNEXUS = {
            host = "rpi-*.nwlnexus.net";
            hostname = "%h";
            user = user;
          };
        };
      };
    };
  };
};