local wezterm = require("wezterm")

local config = wezterm.config_builder and wezterm.config_builder() or {}

-- Font
config.font_size = 12.5
config.custom_block_glyphs = false

config.font = wezterm.font({
	family = "JBM Custom",
})

config.cell_width = 1.00
config.line_height = 1.00

-- Appearance
config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.95
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

-- Window
config.window_decorations = "NONE"
config.initial_cols = 82
config.initial_rows = 24

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 800

-- Scrollback
config.scrollback_lines = 10000

-- Keybindings
config.keys = require("keymaps")

return config
