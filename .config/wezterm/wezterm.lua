-- Author: Nuncvc1v0
-- WEZTERM CONFIGURATION

local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.enable_wayland = false
config.warn_about_missing_glyphs = false

config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 11.0

config.window_background_opacity = 0.95
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 5,
}

config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 750

config.colors = {
  foreground = '#c0caf5',
  background = '#1a1b26',

  cursor_bg = '#c0caf5',
  cursor_fg = '#1a1b26',
  cursor_border = '#c0caf5',

  selection_bg = '#33467c',
  selection_fg = '#c0caf5',

  ansi = {
    '#15161e', -- black
    '#f7768e', -- red
    '#9ece6a', -- green
    '#e0af68', -- yellow
    '#7aa2f7', -- blue
    '#bb9af7', -- magenta
    '#7dcfff', -- cyan
    '#a9b1d6', -- white
  },
  brights = {
    '#414868', -- light-black
    '#ff899d', -- light-red
    '#9fe044', -- light-green
    '#faba4a', -- light-yellow
    '#8db0ff', -- light-blue
    '#c7a9ff', -- light-magenta
    '#a4daff', -- light-cyan
    '#c0caf5', -- light-white
  },
}

local act = wezterm.action
config.keys = {
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
  
  { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = act.ResetFontSize },
}

return config