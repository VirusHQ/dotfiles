local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Text
config.font = wezterm.font_with_fallback { 'JetBrains Mono', 'Menlo' }
config.font_size = 13.0
config.line_height = 1.0
config.harfbuzz_features = { 'calt=0', 'liga=0' } -- no ligatures: show code exactly as typed

-- Look: solid, minimal
config.color_scheme = 'Tokyo Night'
config.window_background_opacity = 1.0
config.window_decorations = 'RESIZE'
config.window_padding = { left = 6, right = 6, top = 4, bottom = 8 }
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.audible_bell = 'Disabled'
config.window_close_confirmation = 'NeverPrompt'

-- Speed
config.front_end = 'OpenGL'
config.max_fps = 120
config.animation_fps = 1
config.cursor_blink_rate = 0
config.scrollback_lines = 20000
config.check_for_updates = false

-- Keys: Option acts as Alt (needed for fzf Alt-C, word jumps)
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true -- right Option still types special chars
config.keys = {
  { key = 'LeftArrow',  mods = 'CMD', action = wezterm.action.SendString '\x01' }, -- line start
  { key = 'RightArrow', mods = 'CMD', action = wezterm.action.SendString '\x05' }, -- line end
  { key = 'k', mods = 'CMD', action = wezterm.action.ClearScrollback 'ScrollbackAndViewport' },
}

return config
