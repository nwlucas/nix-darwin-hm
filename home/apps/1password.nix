{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.d.apps.onepassword;
in

{
  options.d.apps.onepassword = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };

    ssh = mkOption {
      type = types.submodule {
        options = {
          # https://developer.1password.com/docs/ssh/get-started
          key = mkOption {
            type = types.str;
            default =
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBvhX5961G5kV7a9/p6nEBriBRUqE691VCcRDkot8EXD";
          };

          agent = mkOption {
            type = types.str;
            default =
              if pkgs.stdenv.isDarwin then
                "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
              else
                "~/.1password/agent.sock";
          };

          sign = mkOption {
            type = types.str;
            default =
              if pkgs.stdenv.isDarwin then
                "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
              else
                "${pkgs._1password-gui}/share/1password/op-ssh-sign";
          };
        };
      };
      default = { };
    };
  };

  config = mkIf cfg.enable {
    # Use for SSH Authentication and Signing
    d.shell.variables = {
      SSH_AUTH_SOCK = cfg.ssh.agent;
    };

    programs.ssh.extraConfig = ''
      IdentityAgent "${cfg.ssh.agent}"
    '';

    # Load 1Password Shell Plugins
    d.shell.sources = [
      "$HOME/.config/op/plugins.sh"
    ];

    d.autostart._1password-gui = {
      exec = "1password --silent";
    };
  };
}
