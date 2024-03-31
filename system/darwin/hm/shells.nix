{ pkgs, lib, ... }:
{
  # Change the default shell to zsh
  home.activation = {
    setDefaultShell = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [[ "$SHELL" != *zsh ]]
      then
        $DRY_RUN_CMD /usr/bin/chsh -s /run/current-system/sw/bin/zsh
      fi
    '';
  };

  programs = {
    atuin.enable = true;

    bat = {
      enable = true;
      config = {
        theme = "TwoDark";
      };
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      icons = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        "$schema" = "https://starship.rs/config-schema.json";
        add_newline = false;
        # "aws"= {
        #   "disabled": true,
        #   "format": "\\[[$symbol($profile)(\\($region\\))(\\[$duration\\])]($style)\\]"
        # },
        # "battery": {
        #   "disabled": true
        # },
        # "bun": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "c": {
        #   "format": "\\[[$symbol($version(-$name))]($style)\\]"
        # },
        # "cmake": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "cmd_duration": {
        #   "format": "\\[[⏱ $duration]($style)\\]"
        # },
        # "cobol": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "conda": {
        #   "format": "\\[[$symbol$environment]($style)\\]"
        # },
        # "crystal": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "daml": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "dart": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "deno": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "docker_context": {
        #   "format": "\\[[$symbol$context]($style)\\]"
        # },
        # "dotnet": {
        #   "format": "\\[[$symbol($version)(🎯 $tfm)]($style)\\]"
        # },
        # "elixir": {
        #   "format": "\\[[$symbol($version \\(OTP $otp_version\\))]($style)\\]"
        # },
        # "elm": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "erlang": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "fennel": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "fossil_branch": {
        #   "format": "\\[[$symbol$branch]($style)\\]"
        # },
        # "gcloud": {
        #   "format": "\\[[$symbol$account(@$domain)(\\($region\\))]($style)\\]"
        # },
        # "git_branch": {
        #   "format": "\\[[$symbol$branch]($style)\\]"
        # },
        # "git_status": {
        #   "format": "([\\[$all_status$ahead_behind\\]]($style))"
        # },
        # "golang": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "gradle": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "guix_shell": {
        #   "format": "\\[[$symbol]($style)\\]"
        # },
        # "haskell": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "haxe": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "helm": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "hg_branch": {
        #   "format": "\\[[$symbol$branch]($style)\\]"
        # },
        # "java": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "julia": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "kotlin": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "kubernetes": {
        #   "format": "\\[[$symbol$context( \\($namespace\\))]($style)\\]"
        # },
        # "lua": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "memory_usage": {
        #   "format": "\\[$symbol[$ram( | $swap)]($style)\\]"
        # },
        # "meson": {
        #   "format": "\\[[$symbol$project]($style)\\]"
        # },
        # "nim": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "nix_shell": {
        #   "format": "\\[[$symbol$state( \\($name\\))]($style)\\]"
        # },
        # "nodejs": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "ocaml": {
        #   "format": "\\[[$symbol($version)(\\($switch_indicator$switch_name\\))]($style)\\]"
        # },
        # "opa": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "openstack": {
        #   "format": "\\[[$symbol$cloud(\\($project\\))]($style)\\]"
        # },
        # "os": {
        #   "format": "\\[[$symbol]($style)\\]"
        # },
        # "package": {
        #   "format": "\\[[$symbol$version]($style)\\]"
        # },
        # "perl": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "php": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "pijul_channel": {
        #   "format": "\\[[$symbol$channel]($style)\\]"
        # },
        # "pulumi": {
        #   "format": "\\[[$symbol$stack]($style)\\]"
        # },
        # "purescript": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "python": {
        #   "format": "\\[[${symbol}${pyenv_prefix}(${version})(\\($virtualenv\\))]($style)\\]"
        # },
        # "raku": {
        #   "format": "\\[[$symbol($version-$vm_version)]($style)\\]"
        # },
        # "red": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "ruby": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "rust": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "scala": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "solidity": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "spack": {
        #   "format": "\\[[$symbol$environment]($style)\\]"
        # },
        # "sudo": {
        #   "format": "\\[[as $symbol]($style)\\]"
        # },
        # "swift": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "terraform": {
        #   "format": "\\[[$symbol$workspace]($style)\\]"
        # },
        # "time": {
        #   "format": "\\[[$time]($style)\\]"
        # },
        # "username": {
        #   "format": "\\[[$user]($style)\\]"
        # },
        # "vagrant": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "vlang": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # },
        # "zig": {
        #   "format": "\\[[$symbol($version)]($style)\\]"
        # }
      };
    };

    wezterm = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      envExtra = ''
        #make sure brew is on the path for M1
        if [[ $(uname -m) == 'arm64' ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
      '';
      initExtra = ''
        source "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
        source "${pkgs.asdf-vm}/share/asdf-vm/completions/asdf.bash"
      '';
      shellAliases = {
        cat = "bat";
        catp = "bat -P";
      };
    };
  };
}
