return {
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
}
