{
  lib,
  theme,
  user,
  config,
  ...
}:

let
  themes = {
    "catppuccin" = "Catppuccin Mocha";
  };

  # Try to get hostname from system config
  hostname = config.networking.hostName or (builtins.getEnv "HOSTNAME");

  replacements = {
    "@d.theme@" = themes.${theme};
    "@d.user@" = "${user}";
    "@d.user_host@" = "${user}@${hostname}";
  };

  luaConfig =
    builtins.replaceStrings (builtins.attrNames replacements) (builtins.attrValues replacements)
      (lib.readFile ./config.lua);
in

{
  d.shell.variables = {
    TERMINAL = "wezterm";
  };

  xdg.configFile."wezterm/wezterm.lua".text = luaConfig;
}
