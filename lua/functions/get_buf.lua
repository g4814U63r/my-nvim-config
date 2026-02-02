local M = {}
local function get_current_buffer_dir()
	local file_path = vim.api.nvim_buf_get_name(0)
	if file_path == "" then
		return vim.fn.getcwd()
	end
	local dir_path = vim.fn.fnamemodify(file_path, ":h")
	return dir_path
end
function M.close_buf_open_oil()
	local dir_path = get_current_buffer_dir()
	if vim.bo.modified then
		vim.notify(
			"Current buffer has unsaved changes. Use :bd! to force close.",
			vim.log.levels.WARN,
			{ title = "Unsaved changes" }
		)
		return
	end
	vim.cmd("bd")
	require("Oil").open(dir_path)
end

return M
