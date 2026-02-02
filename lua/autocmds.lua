-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
	end,
})
-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "OilEnter",
-- 	callback = function(args)
-- 		local oil = require("oil")
-- 		-- Ensure we are in the oil buffer and not in a preview window already
-- 		if vim.api.nvim_get_current_buf() == args.data.buf then
-- 			vim.schedule(function()
-- 				-- Use open_preview instead of select to avoid "jumping" out of oil
-- 				oil.open_preview()
-- 			end)
-- 		end
-- 	end,
-- })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "svelte",
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
	end,
})
