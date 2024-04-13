{
  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = false;
  };

  programs.nix-index-database.comma.enable = true;
}
