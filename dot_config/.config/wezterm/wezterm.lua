local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback({
  { family = "Cica" },
  { family = "Cica", assume_emoji_presentation = true },
})

config.color_scheme = 'Molokai'
config.window_background_opacity = 0.85
config.hide_tab_bar_if_only_one_tab = true

return config
