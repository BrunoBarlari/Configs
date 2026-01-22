local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Color scheme (Tokyo Night)
config.color_scheme = 'Tokyo Night'

-- Font configuration
config.font = wezterm.font('JetBrains Mono', { weight = 'Medium' })
config.font_size = 14.0

-- Window configuration
config.window_padding = {
  left = 16,
  right = 16,
  top = 16,
  bottom = 16,
}
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.98
config.macos_window_background_blur = 20

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = true

-- Cursor
config.default_cursor_style = 'SteadyBar'

-- Bell
config.audible_bell = "Disabled"

-- Scrollback
config.scrollback_lines = 10000

-- Key bindings
config.keys = {
  -- Split panes
  { key = 'd', mods = 'CMD', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'CMD|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  -- Close pane
  { key = 'w', mods = 'CMD', action = wezterm.action.CloseCurrentPane { confirm = true } },
  -- Navigate panes
  { key = 'h', mods = 'CMD|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'CMD|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'CMD|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'CMD|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
}

return config
