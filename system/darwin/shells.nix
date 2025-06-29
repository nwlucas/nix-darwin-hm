{
  pkgs,
  lib,
  user,
  ...
}:
let
  homePrefix = if pkgs.stdenv.isDarwin then "/Users" else "/home";
in
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
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      envExtra = ''
        #make sure brew is on the path for M1
        if [[ $(uname -m) == 'arm64' ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi

        # Read system-wide modifications.
        if test -f ~/.zshenv.local; then
          source ~/.zshenv.local
        fi
      '';
      # initExtra = ''
      #   source "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
      #   source "${pkgs.asdf-vm}/share/asdf-vm/completions/asdf.bash"
      # '';
      initContent = ''
        source "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
        export PATH="$(brew --prefix python)/libexec/bin:$PATH"
      '';
      shellAliases = {
        switch = "sudo darwin-rebuild switch --flake ${homePrefix}/${user}/nix-darwin-hm";
      };
    };
  };
}
