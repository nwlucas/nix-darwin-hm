{ pkgs, ... }:
{
  environment = {
    shells = [ pkgs.zsh ];
    pathsToLink = [ "/share/zsh" ];
  };

  programs = {
    bash = {
      completion = {
        enable = true;
      };
    };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };

    gnupg.agent.enable = true;

    zsh.enable = true;
    zsh.enableCompletion = true;
    zsh.enableBashCompletion = true;
    zsh.variables = {
      HOMEBREW_BAT = "1";
      HOMEBREW_CURLRC = "1";
    };
  };
}
