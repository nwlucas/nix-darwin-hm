local wz = require("wezterm")
local act = wz.action

-- List of remote hosts to open tabs for
local remote_hosts = {
  {
    ssh_user     = "@d.user@",
    ssh_host     = "hades.nwlnexus.net",
    tmux_session = "@d.user_host@",
  },
  -- Add more hosts if desired
  -- {
  --   ssh_user      = "pi",
  --   ssh_host      = "192.168.248.10",
  --   tmux_session  = "pi-cluster",
  -- },
}

-- Helper to build startup tabs
local function build_startup_tabs()
  local tabs = {
    {
      args = { wz.executable }, -- local shell
      title = wz.hostname(),
    },
  }

  for _, host in ipairs(remote_hosts) do
    table.insert(tabs, {
      args = {
        "ssh",
        string.format("%s@%s", host.ssh_user, host.ssh_host),
        "-t",
        string.format("tmux new-session -A -s %s", host.tmux_session),
      },
      title = host.ssh_host,
    })
  end

  return tabs
end

-- Merge with your config
local config = {
  -- Font
  font = wz.font_with_fallback({
    "JetBrains Mono",
    "Source Code Pro",
    { family = "Symbols Nerd Font Mono", scale = 0.8 },
    { family = "PowerlineSymbols",       scale = 0.8 },
    { family = "Noto Color Emoji",       scale = 0.8 },
  }),
  font_size = 13.0,
  allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",
  adjust_window_size_when_changing_font_size = false,
  warn_about_missing_glyphs = true,

  -- Colors
  color_scheme = "@d.theme@",

  -- Cursor
  default_cursor_style = "SteadyBlock",
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",
  cursor_blink_rate = 500,

  scrollback_lines = 10000,
  enable_kitty_keyboard = true,

  -- Window
  enable_wayland = false,
  window_padding = {
    left = "0cell",
    right = "0cell",
    top = "0cell",
    bottom = "0cell",
  },
  window_close_confirmation = "NeverPrompt",
  window_decorations = "INTEGRATED_BUTTONS|RESIZE|MACOS_FORCE_ENABLE_SHADOW",
  native_macos_fullscreen_mode = true,

  -- Tabs
  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = false,

  -- Keybindings
  disable_default_key_bindings = false,

  -- Startup behavior
  default_gui_startup_args = { "start" },
}

-- macOS override
if string.match(wz.target_triple, "apple") then
  config.window_decorations = "TITLE | RESIZE"
end

-- On startup, spawn all defined tabs
wz.on("gui-startup", function()
  local tabs = build_startup_tabs()
  local _, _, window = wz.mux.spawn_window({})

  for _, tab_info in ipairs(tabs) do
    local tab = window:spawn_tab {
      args = tab_info.args,
    }
    tab:set_title(tab_info.title)
  end

  -- Close the default empty tab
  window:active_tab():kill()
end)

-- Dynamic tab titles: show current program/tmux title
wz.on("format-tab-title", function(tab)
  return { { Text = tab.active_pane.title or tab:get_title() } }
end)

return config
