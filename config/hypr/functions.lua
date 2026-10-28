local M = {}

local workspace_config = require("workspace_config")

local function get_workspace_from_monitor(monitor, index)
	for priority, name in ipairs(workspace_config.monitor_priority) do
		if monitor.name == name then
			return tostring((priority - 1) * workspace_config.count + tonumber(index))
		end
	end

	return tostring(index)
end

function M.swap_workspace_contents(index)
	local monitor = hl.get_active_monitor()
	local current_workspace = monitor and monitor.active_workspace
	if not current_workspace then
		return
	end

	local target_workspace = get_workspace_from_monitor(monitor, index)
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

function M.swap_monitor_contents()
	local current_monitor = hl.get_active_monitor()
	if not current_monitor then
		return
	end

	local monitors = hl.get_monitors()
	if #monitors < 2 then
		return
	end

	local current_index
	for i, monitor in ipairs(monitors) do
		if monitor.id == current_monitor.id then
			current_index = i
			break
		end
	end
	if not current_index then
		return
	end

	local target_monitor = monitors[current_index % #monitors + 1]
	local workspace_count = workspace_config.count

	for index = 1, workspace_count do
		local current_workspace = get_workspace_from_monitor(current_monitor, index)
		local target_workspace = get_workspace_from_monitor(target_monitor, index)
		if current_workspace ~= target_workspace then
			local current_windows = hl.get_workspace_windows(current_workspace)
			local target_windows = hl.get_workspace_windows(target_workspace)
			local temporary_workspace = "name:__monitor_swap_" .. os.time() .. "_" .. current_monitor.id .. "_" .. index

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
	end
end

return M
