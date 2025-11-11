{ lib, user, ... }:
{
  programs = {
    ssh = {
      enable = true;
      addKeysToAgent = "yes";
      extraConfig = ''
        IdentitiesOnly yes
      '';

      matchBlocks = {
        sshNWLNEXUS = {
          host = "*.ssh.nwlnexus.net";
          hostname = "%h";
          user = user;
          proxyCommand = "/opt/homebrew/bin/cloudflared access ssh --hostname %n";
        };
        ghPersonal = {
          host = "github.com";
          hostname = "%h";
          user = "git";
          identityFile = "%d/.ssh/id_ed25519";
        };
        ghDTLR = {
          host = "github.com-work";
          hostname = "github.com";
          user = "git";
          identityFile = "%d/.ssh/glab-work";
          extraOptions = {
            IdentitiesOnly = "yes";
          };
        };
        dtlrSwitches = {
          host = "10.254.0.*";
          user = "manager";
          forwardAgent = true;
          extraOptions = {
            PubkeyAcceptedKeyTypes = "ssh-rsa";
            HostKeyAlgorithms = "ssh-rsa";
            KexAlgorithms = "+diffie-hellman-group14-sha1";
          };
        };
        dtlrSwitches2 = {
          host = "10.220.0.*";
          user = "manager";
          forwardAgent = true;
          extraOptions = {
            PubkeyAcceptedKeyTypes = "ssh-rsa";
            HostKeyAlgorithms = "ssh-rsa";
            KexAlgorithms = "+diffie-hellman-group14-sha1";
          };
        };
        dtlrSwitches3 = {
          host = "10.221.0.*";
          user = "manager";
          forwardAgent = true;
          extraOptions = {
            PubkeyAcceptedKeyTypes = "ssh-rsa";
            HostKeyAlgorithms = "ssh-rsa";
            KexAlgorithms = "+diffie-hellman-group14-sha1";
          };
        };
        sshDTLRONLINE = {
          host = "*.ssh.dtlronline.com";
          hostname = "%h";
          user = user;
          proxyCommand = "/opt/homebrew/bin/cloudflared access ssh --hostname %n";
        };
        sshDTLRSTORES = lib.hm.dag.entryBefore [ "sshDTLRONLINE" ] {
          host = "*.ssh.store.dtlronline.com";
          hostname = "%h";
          user = "dtlr_it";
          identityFile = "%d/.ssh/reliant/id_rsa";
          forwardAgent = true;
          proxyCommand = "/opt/homebrew/bin/cloudflared access ssh --hostname %n";
        };
        tailScaleHosts = {
          host = "*.raptor-mimosa.ts.net";
          forwardAgent = true;
          compression = true;
        };
        onePassword = {
          host = "* exec \"test -z $SSH_TTY\"";
          identityAgent = "\"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
        };
      };
    };
  };
}
