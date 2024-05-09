{ config, pkgs, user, lib, ... }:

let
  aliases = {
    g = "git status";
    ga = "git add .";
    gbr = "git branch -av";
    gbrn = "git !git branch | grep \"^*\" | awk '{ print $2 }'";
    gbrd = "git branch -D";
    gcm = "git commit -m";
    gco = "git checkout";
    gd = "git diff";
    gl = "git log";
    grs = "git restore";
    gs = "git switch";
    gp = "git pull";
    gP = "git push";
  };
in

{
  imports = [
    ./delta.nix
    ./ui.nix
  ];

  home.packages = with pkgs; [
    git-ignore
  ];

  d.shell.aliases = aliases;

  programs = {
    # fish.shellAbbrs = aliases;

    git = {
      enable = true;

      aliases = {
        g = "!git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
        l = "!f() { git log $* | grep '^commit ' | cut -f 2 -d ' '; }; f";
        r = "!git ls-files -z --deleted | xargs -0 git rm";
        addremove = "!git r && git add . --all";
        aliases = "!git config --list | grep 'alias\\.' | sed 's/alias\\.\\([^=]*\\)=\\(.*\\)/\\1\\ \t => \\2/' | sort";
        amend = "!git log -n 1 --pretty=tformat:%s%n%n%b | git commit -F - --amend";
        br = "branch -av";
        brname = "!git branch | grep \"^*\" | awk '{ print $2 }'";
        brdel = "branch -D";
        changes = "!f() { git log --pretty=format:'* %s' $1..$2; }; f";
        churn = ''
          !git log --all -M -C --name-only --format='format:' "$@" | sort | grep -v '^$' | uniq -c | sort | awk 'BEGIN {print "count,file"} {print $1 "," $2}'
        '';
        details = "log -n1 -p --format=fuller";
        export = ''
          archive -o latest.tar.gz -9 --prefix=latest/
        '';
        root = "rev-parse --show-toplevel";
        subup = "submodule update --init";
        tags = "tag -l";
        this = "!git init && git add . && git commit -m \"Initial commit.\"";
        trim = "!git reflog expire --expire=now --all && git gc --prune=now";
        unstage = "reset HEAD --";
      };

      userName = "Nigel Williams-Lucas";
      userEmail = "4689066+nwlucas@users.noreply.github.com";
      ignores = [ ".DS_Store" ];

      # Signing is done via the 1Password app
      signing = {
        signByDefault = false;
        key = config.d.apps.onepassword.ssh.key;
      };

      includes = [
        {
          condition = "gitdir:~/projects/work";
          contentSuffix = "gitconfig-work";
          contents = {
            user = {
              email = "59927973+nwilliams-lucas@users.noreply.github.com";
              name = "Nigel Williams-Lucas";
            };
          };
        }
      ];

      extraConfig = {
        init.defaultBranch = "main";

        gpg = {
          format = "ssh";
          ssh.program = config.d.apps.onepassword.ssh.sign;
        };

        log = {
          decorate = true;
          abbrevCommit = true;
        };

        pull.rebase = false;

        # Autostash on "git pull ..."
        merge.autoStash = true;
        rebase.autoStash = true;

        push.autoSetupRemote = true;

        http = {
          sslCAInfo = "~/Cloudflare_CA.pem";
        };
      };
    };
  };
}
