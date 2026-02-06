return {
	"vifm/vifm.vim",
	"troyfletcher/vim-colors-synthwave",
	"MunifTanjim/nui.nvim",
	"oskarnurm/koda.nvim",
	"edeneast/nightfox.nvim",
	"bluz71/vim-moonfly-colors",
	"water-sucks/darkrose.nvim",
	"noahfrederick/vim-hemisu",
	"bluz71/vim-moonfly-colors",
	"owickstrom/vim-colors-paramount",
	"psliwka/termcolors.nvim",
	"Old-Farmer/noctis-nvim",
	"rktjmp/lush.nvim",
	"vim-scripts/darkzen-color-scheme",
	"rockerBOO/boo-colorscheme-nvim",
	"ray-x/aurora",
	"NMAC427/guess-indent.nvim", -- Detect tabstop and shiftwidth automatically
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},

		event = "BufReadPost", -- lazy-load when opening a file

		opts = {
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		},

		config = function(_, opts)
			-- Required fold options (must be set before using ufo)
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			require("ufo").setup(opts)

			-- Keymaps
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

			vim.keymap.set("n", "zp", function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end)
		end,
	},

	{
		"eoh-bse/minintro.nvim",
		opts = { color = "#63B0B0" },
		config = true,
		lazy = false,
	},
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	{

		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			-- kickstart.nvim includes a general keymap setup, you can use a similar pattern
			-- or use the on_attach method for buffer-specific keymaps.
			vim.g.nvim_tree_respect_buf_cwd = 1
			local function on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- Default mappings (optional, you can comment this out if you want to define all mappings yourself)
				api.config.mappings.default_on_attach(bufnr)

				-- Custom remap to set the current node as the root
				-- You can change <C-]> to your preferred key combination
				vim.keymap.set("n", "<C-.>", api.tree.change_root_to_node, opts("Change root to node"))

				-- Custom remap to go up to the parent directory/root
				-- You can change - to your preferred key combination (e.g., <BS>)
				-- vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Go to parent directory"))

				-- You can add other custom mappings here
			end

			-- Setup nvim-tree with the on_attach function
			require("nvim-tree").setup({
				on_attach = on_attach,
				-- other setup options...
				filters = {
					dotfiles = true,
				},
			})
		end,
	},

	-- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
	--
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- or if using mini.icons/mini.nvim
		-- dependencies = { "nvim-mini/mini.icons" },
		---@module "fzf-lua"
		---@type fzf-lua.Config|{}
		---@diagnostic disable: missing-fields
		opts = {},
		---@diagnostic enable: missing-fields
	},
	-- Alternatively, use `config = function() ... end` for full control over the configuration.
	-- If you prefer to call `setup` explicitly, use:
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				-- Your gitsigns configuration here
			})
		end,
	},
	--
	-- Here is a more advanced example where we pass configuration
	-- options to `gitsigns.nvim`.
	--
	-- See `:help gitsigns` to understand what the configuration keys do
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			-- animation = true,
			-- insert_at_start = true,
			-- …etc.
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},
	{
		"stevearc/oil.nvim",
		opts = {

			-- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
			-- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
			default_file_explorer = true,
			-- Id is automatically added at the beginning, and name at the end
			-- See :help oil-columns
			columns = {
				"icon",
				-- "permissions",
				-- "size",
				-- "mtime",
			},
			-- Buffer-local options to use for oil buffers
			buf_options = {
				buflisted = false,
				bufhidden = "hide",
			},
			-- Window-local options to use for oil buffers
			win_options = {
				wrap = false,
				signcolumn = "yes:2",
				cursorcolumn = false,
				foldcolumn = "0",
				spell = false,
				list = false,
				conceallevel = 3,
				concealcursor = "nvic",
			},
			-- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
			delete_to_trash = false,
			-- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
			skip_confirm_for_simple_edits = true,
			-- Selecting a new/moved/renamed file or directory will prompt you to save changes first
			-- (:help prompt_save_on_select_new_entry)
			prompt_save_on_select_new_entry = true,
			-- Oil will automatically delete hidden buffers after this delay
			-- You can set the delay to false to disable cleanup entirely
			-- Note that the cleanup process only starts when none of the oil buffers are currently displayed
			cleanup_delay_ms = 2000,
			lsp_file_methods = {
				-- Enable or disable LSP file operations
				enabled = true,
				-- Time to wait for LSP file operations to complete before skipping
				timeout_ms = 1000,
				-- Set to true to autosave buffers that are updated with LSP willRenameFiles
				-- Set to "unmodified" to only save unmodified buffers
				autosave_changes = false,
			},
			-- Constrain the cursor to the editable parts of the oil buffer
			-- Set to `false` to disable, or "name" to keep it on the file names
			constrain_cursor = "editable",
			-- Set to true to watch the filesystem for changes and reload oil
			watch_for_changes = false,
			-- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
			-- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
			-- Additionally, if it is a string that matches "actions.<name>",
			-- it will use the mapping at require("oil.actions").<name>
			-- Set to `false` to remove a keymap
			-- See :help oil-actions for a list of all available actions
			keymaps = {
				["g?"] = { "actions.show_help", mode = "n" },
				["<CR>"] = "actions.select",
				["<C-s>"] = { "actions.select", opts = { vertical = true } },
				["<C-h>"] = { "actions.select", opts = { horizontal = true } },
				["<C-t>"] = { "actions.select", opts = { tab = true } },
				["<C-p>"] = "actions.preview",
				["<C-c>"] = { "actions.close", mode = "n" },
				["<C-l>"] = "actions.refresh",
				["-"] = { "actions.parent", mode = "n" },
				["_"] = { "actions.open_cwd", mode = "n" },
				["`"] = { "actions.cd", mode = "n" },
				["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
				["gs"] = { "actions.change_sort", mode = "n" },
				["gx"] = "actions.open_external",
				["g."] = { "actions.toggle_hidden", mode = "n" },
				["g\\"] = { "actions.toggle_trash", mode = "n" },
			},
			-- Set to false to disable all of the above keymaps
			use_default_keymaps = true,
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = false,
				-- This function defines what is considered a "hidden" file
				is_hidden_file = function(name, bufnr)
					local m = name:match("^%.")
					return m ~= nil
				end,
				-- This function defines what will never be shown, even when `show_hidden` is set
				is_always_hidden = function(name, bufnr)
					return false
				end,
				-- Sort file names with numbers in a more intuitive order for humans.
				-- Can be "fast", true, or false. "fast" will turn it off for large directories.
				natural_order = "fast",
				-- Sort file and directory names case insensitive
				case_insensitive = false,
				sort = {
					-- sort order can be "asc" or "desc"
					-- see :help oil-columns to see which columns are sortable
					{ "type", "asc" },
					{ "name", "asc" },
				},
				-- Customize the highlight group for the file name
				highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
					return nil
				end,
			},
			-- Extra arguments to pass to SCP when moving/copying files over SSH
			extra_scp_args = {},
			-- Extra arguments to pass to aws s3 when creating/deleting/moving/copying files using aws s3
			extra_s3_args = {},
			-- EXPERIMENTAL support for performing file operations with git
			git = {
				-- Return true to automatically git add/mv/rm files
				add = function(path)
					return false
				end,
				mv = function(src_path, dest_path)
					return false
				end,
				rm = function(path)
					return false
				end,
			},
			-- Configuration for the floating window in oil.open_float
			float = {
				-- Padding around the floating window
				padding = 2,
				-- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				max_width = 0,
				max_height = 0,
				border = nil,
				win_options = {
					winblend = 0,
				},
				-- optionally override the oil buffers window title with custom function: fun(winid: integer): string
				get_win_title = nil,
				-- preview_split: Split direction: "auto", "left", "right", "above", "below".
				preview_split = "auto",
				-- This is the config that will be passed to nvim_open_win.
				-- Change values here to customize the layout
				override = function(conf)
					return conf
				end,
			},
			-- Configuration for the file preview window
			preview_win = {
				-- Whether the preview window is automatically updated when the cursor is moved
				update_on_cursor_moved = true,
				-- How to open the preview window "load"|"scratch"|"fast_scratch"
				preview_method = "fast_scratch",
				-- A function that returns true to disable preview on a file e.g. to avoid lag
				disable_preview = function(filename)
					return false
				end,
				-- Window-local options to use for preview window buffers
				win_options = {},
			},
			-- Configuration for the floating action confirmation window
			confirmation = {
				-- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				-- min_width and max_width can be a single value or a list of mixed integer/float types.
				-- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
				max_width = 0.9,
				-- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
				min_width = { 40, 0.4 },
				-- optionally define an integer/float for the exact width of the preview window
				width = nil,
				-- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				-- min_height and max_height can be a single value or a list of mixed integer/float types.
				-- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
				max_height = 0.9,
				-- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
				min_height = { 5, 0.1 },
				-- optionally define an integer/float for the exact height of the preview window
				height = nil,
				border = nil,
				win_options = {
					winblend = 0,
				},
			},
			-- Configuration for the floating progress window
			progress = {
				max_width = 0.9,
				min_width = { 40, 0.4 },
				width = nil,
				max_height = { 10, 0.9 },
				min_height = { 5, 0.1 },
				height = nil,
				border = nil,
				minimized_border = "none",
				win_options = {
					winblend = 0,
				},
			},
			-- Configuration for the floating SSH window
			ssh = {
				border = nil,
			},
			-- Configuration for the floating keymaps help window
			keymaps_help = {
				border = nil,
			},
		},
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		lazy = false,
	},
	{
		"refractalize/oil-git-status.nvim",
		dependencies = {
			"stevearc/oil.nvim",
		},
		opts = {
			win_options = {
				signcolumn = "yes:2",
			},
		},

		config = true,
	},
	{
		"JezerM/oil-lsp-diagnostics.nvim",
		dependencies = { "stevearc/oil.nvim" },
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
	},
	{
		"gruvw/strudel.nvim",
		build = "npm ci",
		config = function()
			require("strudel").setup()
		end,
	},
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"tpope/vim-sleuth",
	},

	-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
	--
	-- This is often very useful to both group configuration, as well as handle
	-- lazy loading plugins that don't need to be loaded immediately at startup.
	--
	-- For example, in the following configuration, we use:
	--  event = 'VimEnter'
	--
	-- which loads which-key before all the UI elements are loaded. Events can be
	-- normal autocommands events (`:help autocmd-events`).
	--
	-- Then, because we use the `opts` key (recommended), the configuration runs
	-- after the plugin has been loaded as `require(MODULE).setup(opts)`.

	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		opts = {
			-- delay between pressing a key and opening which-key (milliseconds)
			-- this setting is independent of vim.o.timeoutlen
			delay = 0,
			icons = {
				-- set icon mappings to true if you have a Nerd Font
				mappings = vim.g.have_nerd_font,
				-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
				-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
				keys = vim.g.have_nerd_font and {} or {
					Up = "<Up> ",
					Down = "<Down> ",
					Left = "<Left> ",
					Right = "<Right> ",
					C = "<C-…> ",
					M = "<M-…> ",
					D = "<D-…> ",
					S = "<S-…> ",
					CR = "<CR> ",
					Esc = "<Esc> ",
					ScrollWheelDown = "<ScrollWheelDown> ",
					ScrollWheelUp = "<ScrollWheelUp> ",
					NL = "<NL> ",
					BS = "<BS> ",
					Space = "<Space> ",
					Tab = "<Tab> ",
					F1 = "<F1>",
					F2 = "<F2>",
					F3 = "<F3>",
					F4 = "<F4>",
					F5 = "<F5>",
					F6 = "<F6>",
					F7 = "<F7>",
					F8 = "<F8>",
					F9 = "<F9>",
					F10 = "<F10>",
					F11 = "<F11>",
					F12 = "<F12>",
				},
			},

			-- Document existing key chains
			spec = {
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			},
		},
	},

	-- NOTE: Plugins can specify dependencies.
	--
	-- The dependencies are proper plugin specifications as well - anything
	-- you do for a plugin at the top level, you can do for a dependency.
	--
	-- Use the `dependencies` key to specify the dependencies of a particular plugin
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
		},
		cmd = "Neogit",
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
		},
	},
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different things that
			-- it can fuzzy find! It's more than just a "file finder", it can search
			-- many different aspects of Neovim, your workspace, LSP, and more!
			--
			-- The easiest way to use Telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of `help_tags` options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				-- defaults = {
				--   mappings = {
				--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
				--   },
				-- },
				-- pickers = {}
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[ ] Find existing buffers" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},

	-- LSP Plugins
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			-- Mason must be loaded before its dependents so we need to set it up here.
			-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },

			-- Allows extra capabilities provided by blink.cmp
			"saghen/blink.cmp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- NOTE: Remember that Lua is a real programming language, and as such it is possible
					-- to define small helper and utility functions so you don't have to repeat yourself.
					--
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

					-- Find references for the word under your cursor.
					map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

					-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
					---@param client vim.lsp.Client
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer some lsp support methods only in specific files
					---@return boolean
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- Diagnostic Config
			-- See :help vim.diagnostic.Opts
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			capabilities.textDocument = capabilities.textDocument or {}
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				clangd = {},
				-- gopls = {},
				pyright = {},
				-- rust_analyzer = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`ts_ls`) will work just fine
				vtsls = {},
				html = {},
				cssls = {
					settings = {
						css = {
							lint = {
								unknownAtRules = "ignore",
							},
						},
						scss = { validate = false },
						less = { validate = false },
					},
				},
				jsonls = {},
				tailwindcss = {
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"html",
						"svelte",
						"vue",
					},
					root_dir = require("lspconfig.util").root_pattern(
						"tailwind.config.js",
						"tailwind.config.ts",
						"postcss.config.js",
						"postcss.config.ts",
						"package.json" -- Optional: good fallback for project root
					),
					settings = {
						tailwindCSS = {
							includeLanguages = {
								svelte = "html",
							},
							lint = {
								unusedClasses = "warning",
								cssConflict = "warning",
							},
						},
					},
				},
				svelte = {
					-- This forces the server to only care about your project folder
					root_dir = require("lspconfig.util").root_pattern("svelte.config.js", "package.json", ".git"),
					settings = {
						svelte = {
							plugin = {
								typescript = { enabled = true },
								css = { validate = true },
							},
						},
						watch = {
							ignored = {
								"**/node_modules/**",
								"**/.git/**",
								"/home/gab/.local/**",
								"/home/gab/Desktop/**", -- Just in case
							},
						},
					},
				},
				--

				lua_ls = {
					-- cmd = { ... },
					-- filetypes = { "css", "html", "javascript", "c#", "php", "python" },
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			-- Ensure the servers and tools above are installed
			--
			-- To check the current status of installed tools and/or manually install
			-- other tools, you can run
			--    :Mason
			--
			-- You can press `g?` for help in this menu.
			--
			-- `mason` had to be setup earlier: to configure its options see the
			-- `dependencies` table for `nvim-lspconfig` above.
			--
			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						print(server_name .. " has settings: " .. vim.inspect(server.settings))
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
			require("ufo").setup({
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			-- Remove "mxsdev/nvim-dap-vscode-js" from here
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- UI
			dapui.setup({
				controls = {
					element = "repl",
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⏎",
						step_over = "➜",
						step_out = "OUT",
						step_back = "BCK",
						run_last = "⏎",
						terminate = "✕",
						disconnect = "⏏",
					},
				},
			})

			-- Install adapters via Mason
			require("mason-nvim-dap").setup({
				ensure_installed = { "php-debug-adapter", "js-debug-adapter" },
				automatic_installation = true,
				handlers = {},
			})

			-- MANUAL JS/TS adapter configuration (replaces dap-vscode-js)
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}

			dap.adapters["pwa-chrome"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}

			-- PHP adapter
			dap.adapters.php = {
				type = "executable",
				command = "node",
				args = {
					vim.fn.stdpath("data") .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js",
				},
			}
			dap.configurations.php = {
				{
					type = "php",
					request = "launch",
					name = "Listen for Xdebug",
					port = 9003,
				},
			}

			local vite_port = 5173 -- Change this when Vite uses a different port
			local ts_configs = {
				{
					type = "pwa-node",
					request = "launch",
					name = "TS: Launch current file (tsx)",
					program = "${file}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					console = "integratedTerminal",
					runtimeExecutable = "/home/gab/.yarn/bin/tsx",
				},
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Chrome: Vite dev server",
					url = "http://localhost:5173",
					webRoot = "${workspaceFolder}/src",
					sourceMaps = true,
					runtimeExecutable = "/usr/bin/google-chrome-stable",
				},
			}
			dap.configurations.typescript = ts_configs
			dap.configurations.javascript = ts_configs
			dap.configurations.typescriptreact = ts_configs
			dap.configurations.javascriptreact = ts_configs
			dap.configurations.svelte = ts_configs

			-- Keymaps
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle Dap UI" })
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dt", function()
				dap.terminate()
				dapui.close()
			end, { desc = "DAP Terminate" })
			vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step Over" })

			dap.set_log_level("TRACE")
			-- Replace your <leader>dc keymap with this:
			vim.keymap.set("n", "<leader>dc", function()
				-- Check if Vite is running
				local handle = io.popen("lsof -i:5173 -sTCP:LISTEN -t 2>/dev/null")
				local result = handle:read("*a")
				handle:close()

				if result == "" then
					vim.notify("Starting Vite dev server first...", vim.log.levels.INFO)
					vim.fn.jobstart("yarn run dev --port 5173 --strictPort", {
						detach = true,
						cwd = vim.fn.getcwd(),
					})
					vim.defer_fn(function()
						dap.continue()
					end, 3000) -- Wait 3 seconds for Vite to start
				else
					dap.continue()
				end
			end, { desc = "Dap Continue" })

			-- Auto-open UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "dapui_*",
				callback = function()
					vim.keymap.set("n", "<CR>", "<CR>", { buffer = true })
					vim.keymap.set("n", "<leader>dc", function()
						vim.notify("Use <leader>dc from your code buffer, not DAP UI", vim.log.levels.WARN)
					end, { buffer = true })
				end,
			})
		end,
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		-- keys = {
		-- 	{
		-- 		"<leader>f",
		-- 		function()
		-- 			require("conform").format({ async = true, lsp_format = "fallback" })
		-- 		end,
		-- 		mode = "",
		-- 		desc = "[F]ormat buffer",
		-- 	},
		-- },
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style.
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return
				end
				return {
					timeout_ms = 3000, -- Increased to 3 seconds for Svelte
					lsp_format = "fallback",
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				php = { "pretty-php" },
				svelte = { "prettier" },
			},
		},
	},

	{ -- Autocompletion
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			-- Snippet Engine
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					-- {
					--   'rafamadriz/friendly-snippets',
					--   config = function()
					--     require('luasnip.loaders.from_vscode').lazy_load()
					--   end,
					-- },
				},
				opts = {},
			},
			"folke/lazydev.nvim",
		},
		--- @module 'blink.cmp'
		--- @type blink.cmp.Config
		opts = {
			keymap = {
				-- 'default' (recommended) for mappings similar to built-in completions
				--   <c-y> to accept ([y]es) the completion.
				--    This will auto-import if your LSP supports it.
				--    This will expand snippets if the LSP sent a snippet.

				-- 'enter' for enter to accept
				-- 'none' for no mappings
				--
				-- For an understanding of why the 'default' preset is recommended,
				-- you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				--
				-- All presets have the following mappings:
				-- <tab>/<s-tab>: move to right/left of your snippet expansion
				-- <c-space>: Open menu or open docs if already open
				-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
				-- <c-e>: Hide menu
				-- <c-k>: Toggle signature help
				--
				-- See :h blink-cmp-config-keymap for defining your own keymap
				preset = "enter",
				["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },

				-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			completion = {
				-- By default, you may press `<c-space>` to show the documentation.
				-- Optionally, set `auto_show = true` to show the documentation after a delay.
				documentation = { auto_show = false, auto_show_delay_ms = 500 },
			},

			sources = {
				default = { "lsp", "path", "snippets", "lazydev" },
				providers = {
					lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				},
			},

			snippets = { preset = "luasnip" },

			-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
			-- which automatically downloads a prebuilt binary when enabled.
			--
			-- By default, we use the Lua implementation instead, but you may enable
			-- the rust implementation via `'prefer_rust_with_warning'`
			--
			-- See :h blink-cmp-config-fuzzy for more information
			fuzzy = { implementation = "lua" },

			-- Shows a signature help window while you type arguments for a function
			signature = { enabled = true },
		},
	},

	{
		"AetherSyscall/AetherAmethyst.nvim",
		priority = 1000,
		config = function()
			require("aetheramethyst").setup({
				transparent = false, -- Enable transparent background
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
					functions = { bold = true },
					variables = {},
				},
			})

			-- Load the variant: 'eclipse' (dark) or 'bliss' (light)
			vim.cmd("colorscheme aetheramethyst-eclipse")
		end,
	},

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"archibate/lualine-time",
		},
		opts = {
			options = {
				theme = "iceberg_dark",
			},
			sections = {
				lualine_z = {
					function()
						return " " .. os.date("%I:%M %p")
					end,
				},
			},
		},
	},

	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			-- local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			-- statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			-- statusline.section_location = function()
			-- return "%2l:%-2v"
			-- end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master", -- backward compatible API
		lazy = false, -- per upstream: no lazy-loading
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
			},
			auto_install = true,
			highlight = { enable = true, additional_vim_regex_highlighting = { "ruby" } },
			indent = { enable = true, disable = { "ruby" } },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
	-- init.lua. If you want these files, they are in the repository, so you can just download them and
	-- place them in the correct locations.

	-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
	--
	--  Here are some example plugins that I've included in the Kickstart repository.
	--  Uncomment any of the lines below to enable them (you will need to restart nvim).
	--
	-- require 'kickstart.plugins.debug',
	-- require 'kickstart.plugins.indent_line',
	-- require 'kickstart.plugins.lint',
	-- require 'kickstart.plugins.autopairs',
	-- require 'kickstart.plugins.neo-tree',
	-- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

	-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
	--    This is the easiest way to modularize your config.
	--
	--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
	-- { import = 'custom.plugins' },
	--
	-- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
	-- Or use telescope!
	-- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
	-- you can continue same window with `<space>sr` which resumes last telescope search
}
