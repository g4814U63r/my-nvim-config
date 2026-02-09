return {
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			auto_hide = false,
			exclude_ft = { "qf" },
			exclude_name = {},
			hide = {
				extensions = false,
				inactive = false,
			},
			icons = {
				buffer_index = false,
				buffer_number = false,
				button = "",
				diagnostics = {
					[vim.diagnostic.severity.ERROR] = { enabled = true },
					[vim.diagnostic.severity.WARN] = { enabled = false },
					[vim.diagnostic.severity.INFO] = { enabled = false },
					[vim.diagnostic.severity.HINT] = { enabled = true },
				},
				gitsigns = {
					added = { enabled = true, icon = "+" },
					changed = { enabled = true, icon = "~" },
					deleted = { enabled = true, icon = "-" },
				},
				filetype = {
					custom_colors = false,
					enabled = true,
				},
				separator = { left = "▎", right = "" },
				separator_at_end = true,
				modified = { button = "●" },
				pinned = { button = "", filename = true },
				preset = "default",
				alternate = { filetype = { enabled = false } },
				current = { buffer_index = false },
				inactive = { button = "×" },
				visible = { modified = { buffer_number = false } },
			},
		},
		version = "^1.0.0",
		config = function(_, opts)
			require("barbar").setup(opts)

			-- Autocmd to prevent certain filetypes from appearing as buffers in barbar
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"qf", -- quickfix
					"help",
					"man",
					"lspinfo",
					"spectre_panel",
					"lir",
					"DressingSelect",
					"tsplayground",
					"Jaq",
					"TelescopePrompt",
					"noice",
					"notify",
				},
				callback = function()
					vim.cmd([[
						nnoremap <silent> <buffer> q :close<CR> 
						set nobuflisted 
					]])
				end,
			})

			-- Additional protection for diagnostic/location lists
			vim.api.nvim_create_autocmd("BufWinEnter", {
				pattern = "*",
				callback = function(args)
					local buftype = vim.bo[args.buf].buftype
					if buftype == "quickfix" or buftype == "help" or buftype == "nofile" then
						vim.bo[args.buf].buflisted = false
					end
				end,
			})
		end,
	},
}
