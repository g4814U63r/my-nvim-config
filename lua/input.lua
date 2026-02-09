-- =========================================================
-- Leader keys & globals
-- =========================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Mouse support (useful for resizing splits)
vim.opt.mouse = "a"

-- =========================================================
-- Helper
-- =========================================================

local map = vim.keymap.set

-- =========================================================
-- General / Quality-of-life
-- =========================================================

-- Clear search highlights
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Diagnostics
map("n", "<leader>q", vim.diagnostic.setloclist, {
	desc = "Open diagnostic quickfix list",
})

-- =========================================================
-- Clipboard & Paste behavior
-- =========================================================

-- Paste over selection without yanking replaced text
map("x", "p", '"_dP', { desc = "Paste without yanking" })
map("x", "P", '"_dP', { desc = "Paste without yanking" })

-- =========================================================
-- Utilities
-- =========================================================

map("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
map("n", "<A-t>", "<cmd>terminal<CR>a", { desc = "Open terminal buffer" })
map("n", "<leader>on", "<cmd>tabnew<CR>", { desc = "Open new tab" })

map("n", "<leader><F2>", "<cmd>set background=light<CR>", { desc = "Light theme" })
map("n", "<leader><F3>", "<cmd>set background=dark<CR>", { desc = "Dark theme" })

-- =========================================================
-- Navigation & Files
-- =========================================================

map("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", {
	desc = "Toggle NvimTree (current file)",
})

map("n", "-", "<cmd>Oil<CR>", { desc = "Open file explorer" })

-- =========================================================
-- Buffers (Barbar)
-- =========================================================

map("n", "<leader>bd", "<cmd>BufferDelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bc", "<cmd>BufferClose<CR>", { desc = "Close buffer" })
map("n", "<leader>h", "<cmd>BufferPrevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>l", "<cmd>BufferNext<CR>", { desc = "Next buffer" })
map("n", "<leader>b1", "<cmd>BufferFirst<CR>", { desc = "First buffer" })
map("n", "<leader>bad", "<cmd>%bwipeout!<CR>", { desc = "Delete all buffers" })

-- Jump to buffers 1–9
for i = 1, 9 do
	map("n", "<leader>" .. i, function()
		require("barbar.api").goto_buffer(i)
	end, { desc = "Go to buffer " .. i })
end

map("n", "<leader>0", function()
	require("barbar.api").goto_buffer(-1)
end, { desc = "Go to last buffer" })

-- =========================================================
-- Sessions
-- =========================================================

local session_dir = vim.fn.expand("~/VimSessions/")

for i = 0, 9 do
	local session = session_dir .. "Session" .. i .. ".vim"

	map("n", "<leader>," .. i, "<cmd>mksession! " .. session .. "<CR>", {
		desc = "Save session " .. i,
	})

	map("n", "<leader>." .. i, function()
		if vim.fn.filereadable(session) == 1 then
			vim.cmd("silent! %bwipeout")
			vim.cmd("source " .. session)
			print("Session " .. i .. " loaded")
		else
			print("No session found for slot " .. i)
		end
	end, { desc = "Load session " .. i })
end

-- =========================================================
-- Strudel
-- =========================================================

map("n", "<leader>uu", "<cmd>w<CR><cmd>StrudelUpdate<CR>", { desc = "Update Strudel" })
map("n", "<leader>ul", "<cmd>StrudelLaunch<CR>", { desc = "Launch Strudel" })
map("n", "<leader>us", "<cmd>StrudelStop<CR>", { desc = "Stop Strudel" })
map("n", "<leader>uq", "<cmd>StrudelQuit<CR>", { desc = "Quit Strudel" })

-- =========================================================
-- Windows & Splits
-- =========================================================

map("n", "<C-h>", "<C-w>h", { desc = "Move left" })
map("n", "<C-j>", "<C-w>j", { desc = "Move down" })
map("n", "<C-k>", "<C-w>k", { desc = "Move up" })
map("n", "<C-l>", "<C-w>l", { desc = "Move right" })

map("n", "<C-Up>", "<C-w>k")
map("n", "<C-Down>", "<C-w>j")
map("n", "<C-Left>", "<C-w>h")
map("n", "<C-Right>", "<C-w>l")

map("n", "<C-->", "<C-w>-")
map("n", "<C-+>", "<C-w>+")
map("n", "<C-<>", "<C-w><")
map("n", "<C->>", "<C-w>>")

-- =========================================================
-- Terminal
-- =========================================================

map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- =========================================================
-- GUI / Neovide
-- =========================================================

if vim.g.neovide then
	map("n", "<F11>", function()
		vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
	end, { desc = "Toggle fullscreen" })

	map({ "n", "i", "v" }, "<C-Tab>", "<cmd>tabnext<CR>")
	map({ "n", "i", "v" }, "<C-S-Tab>", "<cmd>tabprevious<CR>")
else
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
