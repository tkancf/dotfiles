local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Molokai'
config.window_background_opacity = 0.85
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font_with_fallback({
  { family = "Cica", assume_emoji_presentation = false },
  { family = "Hack Nerd Font Mono", assume_emoji_presentation = true },
})

config.keys = {
  -- タブ操作
  {
    key = "t",
    mods = "CMD",
    action = wezterm.action{ SpawnTab = "CurrentPaneDomain" }
  },
  {
    key = "w",
    mods = "CMD",
    action = wezterm.action{ CloseCurrentTab = { confirm = true } }
  },
  {
    key = "n",
    mods = "CMD",
    action = wezterm.action.ActivateTabRelative(1)
  },
  {
    key = "p",
    mods = "CMD",
    action = wezterm.action.ActivateTabRelative(-1)
  },
  {
    key = "e",
    mods = "CMD",
    action = wezterm.action.ShowTabNavigator
  },
  -- ペイン操作
  {
    key = "5",
    mods = "CMD",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }
  },
  {
    key = "'",
    mods = "CMD",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }
  },
  {
    key = "z",
    mods = "CMD",
    action = wezterm.action.TogglePaneZoomState
  },
  -- クリップボード操作
  {
    key = "c",
    mods = "CMD",
    action = wezterm.action{ CopyTo = "Clipboard" }
  },
  {
    key = "v",
    mods = "CMD",
    action = wezterm.action{ PasteFrom = "Clipboard" }
  },
}

return config
