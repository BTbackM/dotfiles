local terminal = "alacritty"
local browser = "brave"

hl.monitor({
	output = "DP-2",
	mode = "2560x1440@60.00",
	position = "0x0",
	scale = "1.0",
})

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 5,
		border_size = 3,
	},
})

hl.config({
	input = {
		kb_layout = "es",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0,

		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.config({
	decoration = {
		rounding = 3,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = false,
		},
		blur = {
			enabled = false,
		},
	},
})

-- Window rules

hl.window_rule({
	name = "Terminal",
	match = { class = "Alacritty" },
	opacity = 0.90,
})

-- Keybinds

local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(terminal .. " -e 'ranger'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(terminal .. " -e 'nvim'"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)

-- Workspaces
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Window management
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.swap({ direction = "down" }))
