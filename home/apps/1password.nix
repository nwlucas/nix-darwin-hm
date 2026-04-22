{
  config,
  pkgs,
  lib,
  ...
}:

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
            default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBvhX5961G5kV7a9/p6nEBriBRUqE691VCcRDkot8EXD";
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

    # Fetch the GitLab work SSH private key from 1Password at activation time.
    # Update the op:// path below to match your vault/item/field names.
    # Run: op read "op://<vault>/<item>/<field>" to verify the path first.
    home.activation.fetchGitLabWorkKey = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      key_path="$HOME/.ssh/gitlab-work-gl"
      if command -v op &>/dev/null && op account list &>/dev/null 2>&1; then
        op read "op://Employee/GitLab Work SSH/private key" > "$key_path" 2>/dev/null \
          && chmod 600 "$key_path"
      elif [ ! -f "$key_path" ]; then
        echo "Warning: 1Password CLI not signed in and ~/.ssh/gitlab-work-gl is missing." \
             "SSH auth to gitlab-work.com will fail." >&2
      fi
    '';
  };
}
