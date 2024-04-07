{
  d.shell.aliases = {
    j = "__zoxide_zi";
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = false;
  };
}
