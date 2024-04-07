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
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      # initExtra = ''
      #   source "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
      #   source "${pkgs.asdf-vm}/share/asdf-vm/completions/asdf.bash"
      # '';
    };
  };
}
