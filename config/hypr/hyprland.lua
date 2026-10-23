package.path = package.path .. ";./?.lua;./?/init.lua"

local smw = require("plugins.split-monitor-workspaces")
local terminal = "alacritty"
local browser = "brave"
local menu = "wofi --show drun"

smw.setup({
	workspace_count = 10,
})

hl.env("HYPRSHOT_DIR", os.getenv("HOME") .. "/Pictures/Screenshots")

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hyprsunset")
end)

hl.monitor({
	output = "HDMI-A-1",
	mode = "2560x1440@60.00",
	position = "0x0",
	scale = "1.0",
})

hl.monitor({
	output = "DP-3",
	mode = "2560x1440@60.00",
	position = "2560x0",
	scale = "1.0",
	disabled = false,
})

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 5,
		border_size = 3,
		layout = "dwindle",
	},
	dwindle = {
		preserve_split = true,
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
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal .. " -e 'btop'"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(terminal .. " -e 'ranger'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(terminal .. " -e 'nvim'"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)

-- Workspaces
for i = 1, smw.get_amount_of_workspaces() do
	local n = tostring(i)
	if n == "10" then
		n = "0"
	end
	hl.bind(mainMod .. " +" .. n, smw.workspace(n))
	hl.bind(mainMod .. " + SHIFT +" .. n, smw.move_to_workspace_silent(n))
end

-- Window management
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ monitor = "-1" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ monitor = "+1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

-- Screenshots
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("hyprshot -m window"))
