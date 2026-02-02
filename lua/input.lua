-- local current_buffer =
-- See `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- utilities
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
vim.keymap.set("n", "<leader>ot", "<cmd>terminal<CR>", { desc = "Open terminal in new buffer" })
vim.keymap.set("n", "<leader>on", "<cmd>tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open file explorer" })
-- buffer control
vim.keymap.set("n", "<leader>bd", "<cmd>BufferDelete<CR>", { desc = "Delete current buffer" })
vim.keymap.set("n", "<leader>bc", "<cmd>BufferClose<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>b1", "<cmd>BufferFirst<CR>", { desc = "Go to first buffer" })
vim.keymap.set("n", "<leader>l", "<cmd>BufferNext<CR>")
vim.keymap.set("n", "<leader>h", "<cmd>BufferPrevious<CR>")
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Open NvimTree at file location" })

-- FzfLua
vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua colorschemes<CR>", { desc = "Colors" })
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Fzf files" })
vim.keymap.set("n", "<leader>fl", "<cmd>FzfLua buffers<CR>", { desc = "Show buffer list" })
vim.keymap.set("n", "<leader>fz", "<cmd>FzfLua<CR>", { desc = "Open FzfLua menu" })
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua grep<CR>", { desc = "Open FzfLua grep" })

-- -- Session Management
-- local session_dir = vim.fn.expand("~/VimSessions/")
-- if vim.fn.isdirectory(session_dir) == 0 then
-- 	vim.fn.mkdir(session_dir, "p")
-- end
--
-- for i = 0, 9 do
-- 	--
-- 	-- Save session
-- 	vim.keymap.set("n", "<leader>," .. i, function()
-- 		vim.cmd("mksession! " .. session_dir .. "Session" .. i .. ".vim")
-- 		print("Session " .. i .. " saved")
-- 	end, { desc = "Save and overwrite session " .. i })
--
-- 	-- Load session
-- 	vim.keymap.set("n", "<leader>." .. i, function()
-- 		vim.cmd("source " .. session_dir .. "Session" .. i .. ".vim")
-- 		print("Session " .. i .. " loaded")
-- 	end, { desc = "Load session " .. i })
-- end
for i = 1, 9 do
	vim.keymap.set("n", "<leader>" .. i, function()
		require("barbar.api").goto_buffer(i)
	end, { desc = "Go to buffer " .. i })
end
vim.keymap.set("n", "<leader>0", function()
	require("barbar.api").goto_buffer(-1)
end, { desc = "Go to last buffer" })
local session_dir = vim.fn.expand("~/VimSessions/")

for i = 0, 9 do
	local file_path = session_dir .. "Session" .. i .. ".vim"

	-- SAVE: Remains the same
	vim.keymap.set("n", "<leader>," .. i, "<cmd>mksession! " .. file_path .. "<CR>", {
		desc = "Save session " .. i,
	})

	-- LOAD: Now clears existing buffers first to prevent E95
	vim.keymap.set("n", "<leader>." .. i, function()
		-- 1. Check if the file exists before trying to load it
		if vim.fn.filereadable(file_path) == 1 then
			-- 2. Wipe all current buffers to prevent "Buffer already exists" conflicts
			vim.cmd("silent! %bwipeout")
			-- 3. Source the session
			vim.cmd("source " .. file_path)
			print("Session " .. i .. " loaded")
		else
			print("No session file found for slot " .. i)
		end
	end, { desc = "Load session " .. i })
end

-- Strudel
vim.keymap.set("n", "<leader>uu", "<cmd>w<CR><cmd>StrudelUpdate<CR>", { desc = "Update strudel session" })
vim.keymap.set("n", "<leader>ul", "<cmd>StrudelLaunch<CR>", { desc = "Lauch strudel session" })
vim.keymap.set("n", "<leader>us", "<cmd>StrudelStop<CR>", { desc = "Stop strudel playback" })
vim.keymap.set("n", "<leader>uq", "<cmd>StrudelQuit<CR>", { desc = "Exit strudel" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-->", "<C-w>-", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-+>", "<C-w>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C->>", "<C-w>>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-<>", "<C-w><", { noremap = true, silent = true })

if vim.g.neovide == true then
	vim.api.nvim_set_keymap("n", "<F11>", ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {})
	vim.keymap.set({ "n", "i", "v" }, "<C-tab>", "<cmd>tabNext<CR>")
	vim.keymap.set({ "n", "i", "v" }, "<C-S-tab>", "<cmd>tabNext<CR>")
else
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
