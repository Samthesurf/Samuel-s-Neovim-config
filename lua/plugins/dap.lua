return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<leader>db",
				mode = "n",
				":DapToggleBreakpoint<CR>",
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dc",
				mode = "n",
				":DapContinue<CR>",
				desc = "Start debugging",
			},
			{
				"<leader>dt",
				mode = "n",
				":DapStepOver<CR>",
				desc = "Step Over",
			},
		},
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy",
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		enabled = false,
	},
}
