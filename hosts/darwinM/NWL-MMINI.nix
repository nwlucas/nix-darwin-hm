{ pkgs, user, ... }:
let
  homePrefix =
    if pkgs.stdenv.isDarwin
    then "/Users"
    else "/home";
in
{
  config = {
    ids.gids.nixbld = 30000;
    system.primaryUser = user;

    home-manager = {
      users.${user} = {
        home = {
          file = {
            "rpi-ssh" = {
              text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMdSCz3gWpimqj5AiJ5acxGKyaP0hfaZLDUTR+K35dJW";
              target = "hm_dummy/rpi-ssh";
              onChange = ''
              rm -f ${homePrefix}/${user}/.ssh/rpi-ssh
              cp ${homePrefix}/${user}/hm_dummy/rpi-ssh ${homePrefix}/${user}/.ssh/rpi-ssh
              chmod u+rw ${homePrefix}/${user}/.ssh/rpi-ssh
              '';
            };
          };
        };

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
