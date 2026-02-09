-- =========================================================
-- Globals
-- =========================================================

-- Disable netrw (using Oil, Nvim-tree or vifm)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- =========================================================
-- UI & Visuals
-- =========================================================

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.showmode = false
vim.g.have_nerd_font = true

-- Keep signcolumn visible (avoid text shifting)
vim.opt.signcolumn = "yes:2"

-- Whitespace visualization
vim.opt.list = true
vim.opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
}

-- Live preview of substitutions
vim.opt.inccommand = "split"

-- Minimal lines above/below cursor
vim.opt.scrolloff = 10

-- =========================================================
-- Editing Behavior
-- =========================================================

vim.opt.breakindent = true
vim.opt.confirm = true

-- Case-insensitive search unless uppercase is used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- =========================================================
-- Splits & Window Behavior
-- =========================================================

vim.opt.splitright = true
vim.opt.splitbelow = true

-- =========================================================
-- Performance & Responsiveness
-- =========================================================

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- =========================================================
-- Files, Swap, Undo
-- =========================================================

-- Persistent undo
vim.opt.undofile = true

-- Centralized swap files
vim.opt.directory = vim.fn.stdpath("data") .. "/swap//"

-- =========================================================
-- Clipboard
-- =========================================================

-- Scheduled to avoid clipboard provider issues (WSL / SSH)
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- =====================
