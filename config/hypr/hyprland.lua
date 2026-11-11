local config_dir = debug.getinfo(1, "S").source:match("^@(.*/)")
if config_dir then
	package.path = package.path .. ";" .. config_dir .. "?.lua;" .. config_dir .. "?/init.lua"
else
	package.path = package.path .. ";./?.lua;./?/init.lua"
end

local workspace_config = require("workspace_config")
local smw = require("plugins.split-monitor-workspaces")
_G.smw = smw

smw.setup({
	workspace_count = workspace_config.count,
	monitor_priority = workspace_config.monitor_priority,
})

hl.env("HYPRSHOT_DIR", os.getenv("HOME") .. "/Pictures/Screenshots")

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hyprsunset")
end)

require("monitors")
require("settings")
require("window-rules")
require("mappings")
