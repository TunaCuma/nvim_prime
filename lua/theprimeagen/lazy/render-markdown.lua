return {
	"MeanderingProgrammer/render-markdown.nvim",
	opts = {
		heading = {
			backgrounds = {
				"RenderMarkdownH1Bg",
				"RenderMarkdownH5Bg",
				"RenderMarkdownH3Bg",
				"RenderMarkdownH4Bg",
				"RenderMarkdownH5Bg",
				"RenderMarkdownH6Bg",
			},
			foregrounds = {
				"RenderMarkdownH1",
				"RenderMarkdownH5",
				"RenderMarkdownH3",
				"RenderMarkdownH4",
				"RenderMarkdownH5",
				"RenderMarkdownH6",
			},
		},
		latex = {
			enabled = true,
			converter = "latex2text",
			highlight = "RenderMarkdownMath",
			top_pad = 0,
			bottom_pad = 0,
		},
	},
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
	ft = { "markdown" },
	keys = {
		{ "<leader>rm", "<cmd>RenderMarkdown toggle<cr>", desc = "Render markdown" },
	},
}
