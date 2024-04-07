{ pkgs, ... }:
{
  environment = {
    shells = [ pkgs.zsh ];
    pathsToLink = [ "/share/zsh" ];
  };

  programs = {
    bash.enableCompletion = true;

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };

    gnupg.agent.enable = true;

    zsh.enable = true;
  };
}
