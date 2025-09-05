return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({ -- Formatting
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofmt" },
				python = { "ruff_format" },
				markdown = { "prettierd" },

				-- Next.js/React file types
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				json = { "prettierd" },
				css = { "prettierd" },
				scss = { "prettierd" },
				html = { "prettierd" },
				sql = { "sql_formatter" },
			},

			formatters = {
				sql_formatter = {
					args = { "--language", "spark" }, -- Spark SQL support
				},
			},
		})
	end,
}
