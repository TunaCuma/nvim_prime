return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
	--   "BufReadPre path/to/my-vault/**.md",
	--   "BufNewFile path/to/my-vault/**.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = {
			{
				name = "main",
				path = "~/Desktop/obsidian-vault",
			},
		},

		templates = {
			folder = "~/Desktop/obsidian-vault/Templates",
		},
		ui = {
			enable = false,
		},

		-- see below for full list of options 👇
	},
	keys = {
		{
			"<leader>op",
			function()
				-- Generate filename automatically
				local current_file = vim.fn.expand("%:t:r") -- current file name without extension
				local current_dir = vim.fn.expand("%:p:h:t") -- current directory name
				local timestamp = os.date("%Y%m%d_%H%M%S") -- date and time

				-- Create the filename: directory_filename_timestamp.png
				local filename = string.format("%s_%s_%s.png", current_dir, current_file, timestamp)

				-- Replace any spaces or special characters with underscores
				filename = filename:gsub("[%s%W]", "_"):gsub("_+", "_")

				-- Execute ObsidianPasteImg with the generated filename
				vim.cmd("ObsidianPasteImg " .. filename)
			end,
			desc = "Paste Obsidian image with auto-generated name",
		},
	},
}
