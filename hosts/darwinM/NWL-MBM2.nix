{ config, user, ... }:
{
  config = {
    home-manager = {
      users.${user} = {
        home.file.".ssh/id_rpi_ed25519".source = ../../files/id_rpi_ed25519.pub;
        programs = {
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
  };
}