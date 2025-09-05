return {
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",

		dependencies = { "rafamadriz/friendly-snippets" },

		config = function()
			local ls = require("luasnip")
			local s = ls.snippet
			local t = ls.text_node
			local i = ls.insert_node
			local fmt = require("luasnip.extras.fmt").fmt

			ls.filetype_extend("javascript", { "jsdoc" })

			-- Load snippets from external files
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })

			vim.keymap.set({ "i", "s" }, "<C-s>j", function()
				ls.jump(1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-s>k", function()
				ls.jump(-1)
			end, { silent = true })
		end,
	},
}
