{ lib, user, ... }:
{
    programs = {
      ssh = {
        enable = true;
        matchBlocks = {
          sshNWLNEXUS = {
            host          = "*.ssh.nwlnexus.net";
            hostname      = "%h";
            user          = user;
            proxyCommand  = "/opt/homebrew/bin/cloudflared access ssh --hostname %n";
          };
          ghPersonal = {
            host          = "github.com";
            hostname      = "%h";
            user          = "git";
            identityFile  = "%d/.ssh/id_ed25519";
          };
          ghDTLR = {
            host          = "github.com-work";
            hostname      = "github.com";
            user          = "git";
            identityFile  = "%d/.ssh/glab-work";
          };
          sshDTLRONLINE = {
            host          = "*.ssh.dtlronline.com";
            hostname      = "%h";
            user          = user;
            proxyCommand  = "/opt/homebrew/bin/cloudflared access ssh --hostname %n";
          };
          sshDTLRSTORES = lib.hm.dag.entryBefore ["sshDTLRONLINE"] {
            host          = "*.ssh.store.dtlronline.com";
            hostname      = "%h";
            user          = "dtlr_it";
            identityFile  = "%d/.ssh/reliant/id_rsa";
            forwardAgent  = true;
            proxyCommand  = "/opt/homebrew/bin/cloudflared access ssh --hostname %n";
            extraOptions  = { PubkeyAcceptedKeyTypes = "ssh-rsa"; HostKeyAlgorithms = "ssh-dss,ssh-rsa"; };
          };
        };
      };
    };
}
