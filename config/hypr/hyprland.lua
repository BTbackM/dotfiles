package.path = package.path .. ";./?.lua;./?/init.lua"

local workspace_config = require("workspace_config")

hl.config({
	plugin = {
		split_monitor_workspaces = {
			count = workspace_config.count,
		},
	},
})

hl.plugin.split_monitor_workspaces.monitor_priority(workspace_config.monitor_priority)

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
