{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;

    git = true;
    icons = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };
}
