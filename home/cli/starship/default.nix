{ pkgs, ... }:

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
    package = pkgs.starship

    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      add_newline = false;
      erlang = { format = "via [e $version](bold red) "; };
      git_branch = { symbol = "🌱 "; };
      git_commit = {
        commit_hash_length = 4;
        tag_symbol = "🔖 ";
      };
      git_state = {
        format = "[($state($progress_current of $progress_total))]($style) ";
        cherry_pick = "[🍒 PICKING](bold red)";
      };
      git_status = {
        conflicted = "🏳";
        ahead = "🏎💨";
        behind = "😰";
        diverged = "😵";
        untracked = "🤷‍";
        stashed = "📦";
        modified = "📝";
        staged = "[++($count)](green)";
        renamed = "👅";
        deleted = "🗑";
      };
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vimcmd_symbol = "[❮](bold green)";
        vimcmd_visual_symbol = "[❮](bold yellow)";
        vimcmd_replace_symbol = "[❮](bold purple)";
        vimcmd_replace_one_symbol = "[❮](bold purple)";
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

      hostname = {
        ssh_only = false;
        format = "on [work-box](bold red) ";
        disabled = false;
     };

      battery.disabled = true;
      package.disabled = false;
    };
  };
}
