{ pkgs, lib, user, version, ... }:

let
  homePrefix =
    if pkgs.stdenv.isDarwin
    then "/Users"
    else "/home";
in

{
  imports = [
    ./ssh_config.nix
    ./autostart.nix
    ./eza.nix
    ./apps
    ./cli
  ];

  home = {
    file = {
      "Cloudflare_CA" = {
        text = ''
        -----BEGIN CERTIFICATE-----
        MIIDHTCCAsOgAwIBAgIURCw5MNDWeKV9xjY641rGsPE7MGcwCgYIKoZIzj0EAwIw
        gcAxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMRYwFAYDVQQHEw1T
        YW4gRnJhbmNpc2NvMRkwFwYDVQQKExBDbG91ZGZsYXJlLCBJbmMuMRswGQYDVQQL
        ExJ3d3cuY2xvdWRmbGFyZS5jb20xTDBKBgNVBAMTQ0dhdGV3YXkgQ0EgLSBDbG91
        ZGZsYXJlIE1hbmFnZWQgRzEgMzE2YzBiYTk0MjlmMzFjMTRlZGFmNzBhNDgyMjA3
        NjkwHhcNMjQxMjExMTkyOTAwWhcNMjkxMjExMTkyOTAwWjCBwDELMAkGA1UEBhMC
        VVMxEzARBgNVBAgTCkNhbGlmb3JuaWExFjAUBgNVBAcTDVNhbiBGcmFuY2lzY28x
        GTAXBgNVBAoTEENsb3VkZmxhcmUsIEluYy4xGzAZBgNVBAsTEnd3dy5jbG91ZGZs
        YXJlLmNvbTFMMEoGA1UEAxNDR2F0ZXdheSBDQSAtIENsb3VkZmxhcmUgTWFuYWdl
        ZCBHMSAzMTZjMGJhOTQyOWYzMWMxNGVkYWY3MGE0ODIyMDc2OTBZMBMGByqGSM49
        AgEGCCqGSM49AwEHA0IABPaQOVgkrzRB58TvmBomvaNH1cJoRZxtM1Z25eq/DnKZ
        8q2NWZL+N91rzKRKyJ62xJNz+EgFMAyWTIneN69rhPCjgZgwgZUwDgYDVR0PAQH/
        BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFH+i4Q5pdL5lRS/i3onS
        aKqOnrecMFMGA1UdHwRMMEowSKBGoESGQmh0dHA6Ly9jcmwuY2xvdWRmbGFyZS5j
        b20vM2U4ZTM0MTEtOTMxMC00ZTYxLTljNjUtYjUzOTEwZGNhODFhLmNybDAKBggq
        hkjOPQQDAgNIADBFAiBIiZVkJjfztxzPkimJIKtbQdY+wOrg1OJWNTS1spah7AIh
        AMLuNe00+2o61dUlmAACQHak55uSRHk99tRlP98Iv3gi
        -----END CERTIFICATE-----
        '';
        target = "${homePrefix}/${user}/Cloudflare_CA.pem";
      };
      "CurlRC" = {
        text = ''
        --cacert /etc/ssl/certs/ca-certificates.crt
        '';
        target = "${homePrefix}/${user}/.curlrc";
      };
      "asdfrc" = {
        text = ''
        legacy_version_file = yes
        '';
        target = "${homePrefix}/${user}/.asdfrc";
      };
      "gh-ssh" = {
        text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBvhX5961G5kV7a9/p6nEBriBRUqE691VCcRDkot8EXD";
        target = "hm_dummy/gh-ssh";
        onChange = ''
        rm -f ${homePrefix}/${user}/.ssh/id_ed25519
        cp ${homePrefix}/${user}/hm_dummy/gh-ssh ${homePrefix}/${user}/.ssh/id_ed25519
        chmod 0600 ${homePrefix}/${user}/.ssh/id_ed25519
        '';
      };
      "glab-work" = {
        text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMuboq7Wpr2+0SIZoq+MeGW2+5BcvOYnA0k5a6+rvqvC";
        target = "hm_dummy/glab-work";
        onChange = ''
        rm -f ${homePrefix}/${user}/.ssh/glab-work
        cp ${homePrefix}/${user}/hm_dummy/glab-work ${homePrefix}/${user}/.ssh/glab-work
        chmod 0600 ${homePrefix}/${user}/.ssh/glab-work
        '';
      };
    };
    username = user;
    homeDirectory = lib.mkForce "${homePrefix}/${user}";
    stateVersion = version;

    sessionVariables = {
      HOMEBREW_BAT = "1";
      HOMEBREW_CURLRC = "1";
      VOLTA_FEATURE_PNPM = "1";
      GOPATH = "${homePrefix}/${user}/go";
    };

    sessionPath = [
      "${homePrefix}/${user}/.local/bin"
      "${homePrefix}/${user}/go/bin"
    ];
  };

  xdg.enable = true;
  programs.home-manager.enable = true;
  programs.go.enable = true;
  
  programs.zsh = {
    initContent = ''
      # Add ~/.zsh/completion to fpath for custom completions
      [[ -d ~/.zsh/completion ]] || mkdir -p ~/.zsh/completion
      if [[ ! " ''${fpath[*]} " =~ " $HOME/.zsh/completion " ]]; then
        fpath=(~/.zsh/completion $fpath)
      fi
    '';
  };
  
  xsession.numlock.enable = pkgs.stdenv.isLinux;
}
