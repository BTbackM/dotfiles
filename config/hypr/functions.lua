local M = {}

local smw_helpers = require("plugins.split-monitor-workspaces.lua.helpers")

function M.swap_workspace_contents(index)
	local monitor = hl.get_active_monitor()
	local current_workspace = monitor and monitor.active_workspace
	if not current_workspace then
		return
	end

	local target_workspace = smw_helpers.get_workspace_from_monitor(monitor, tostring(index))
	if current_workspace.name == target_workspace then
		return
	end

	local current_windows = hl.get_workspace_windows(current_workspace)
	local target_windows = hl.get_workspace_windows(target_workspace)
	local temporary_workspace = "name:__workspace_swap_" .. os.time() .. "_" .. index

	for _, window in ipairs(current_windows) do
		hl.dispatch(hl.dsp.window.move({ workspace = temporary_workspace, window = window, follow = false }))
	end
	for _, window in ipairs(target_windows) do
		hl.dispatch(hl.dsp.window.move({ workspace = current_workspace, window = window, follow = false }))
	end
	for _, window in ipairs(current_windows) do
		hl.dispatch(hl.dsp.window.move({ workspace = target_workspace, window = window, follow = false }))
	end
end

return M
