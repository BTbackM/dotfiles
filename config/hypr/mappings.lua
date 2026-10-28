local smw = hl.plugin.split_monitor_workspaces
local workspace_config = require("workspace_config")
local functions = require("functions")
local terminal = "alacritty"
local browser = "brave"
local menu = "wofi --show drun"
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
hl.bind(mainMod .. " + SHIFT + M", function()
	functions.swap_monitor_contents()
end)

-- Workspaces
for i = 1, workspace_config.count do
	local index = i
	local n = tostring(i)
	if n == "10" then
		n = "0"
	end
	hl.bind(mainMod .. " +" .. n, function()
		return smw.workspace(n)
	end)
	hl.bind(mainMod .. " + SHIFT +" .. n, function()
		return smw.move_to_workspace_silent(n)
	end)
	hl.bind(mainMod .. " + ALT +" .. n, function()
		functions.swap_workspace_contents(index)
	end)
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
hl.bind("mouse:277", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("hyprshot -m window"))
