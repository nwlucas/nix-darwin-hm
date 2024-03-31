{
  imports = [
    ./themes.nix
  ];

  d.shell.variables = {
    STARSHIP_LOG = "error";
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      add_newline = false;

      character = {
        success_symbol = "[✅](bold prompt)";
        error_symbol = "[🚨](bold red)";
        vicmd_symbol = "[➡️](bold prompt)";
      };

      cmd_duration = {
        format = "[$duration]($style)";
      };

      nix_shell = {
        format = "in [$symbol$state(\\($name\\))]($style) ";
        symbol = "❄️ ";
        impure_msg = "";
        pure_msg = "pure ";
      };

      battery.disabled = true;
      package.disabled = false;
    };
  };
}
