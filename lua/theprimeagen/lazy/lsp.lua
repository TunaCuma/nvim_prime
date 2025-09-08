local root_files = {
	".luarc.json",
	".luarc.jsonc",
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
	"selene.yml",
	".git",
}

local function get_python_path()
	-- Use activated virtualenv.
	if vim.env.VIRTUAL_ENV then
		return require("lspconfig.util").path.join(vim.env.VIRTUAL_ENV, "bin", "python")
	end

	-- Fallback to system Python.
	return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		require("conform").setup({
			formatters_by_ft = {},
		})
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"gopls",
				"basedpyright",
				"ruff",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				zls = function()
					local lspconfig = require("lspconfig")
					lspconfig.zls.setup({
						root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
						settings = {
							zls = {
								enable_inlay_hints = true,
								enable_snippets = true,
								warn_style = true,
							},
						},
					})
					vim.g.zig_fmt_parse_errors = 0
					vim.g.zig_fmt_autosave = 0
				end,
				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						on_init = function(client)
							local path = client.workspace_folders[1].name
							if
								vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc")
							then
								return
							end

							client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
								runtime = {
									-- Tell the language server which version of Lua you're using
									-- (most likely LuaJIT in the case of Neovim)
									version = "LuaJIT",
								},
								-- Make the server aware of Neovim runtime files
								workspace = {
									checkThirdParty = false,
									library = {
										vim.env.VIMRUNTIME,
										-- Depending on the usage, you might want to add additional paths here.
										-- "${3rd}/luv/library"
										-- "${3rd}/busted/library",
									},
									-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
									-- library = vim.api.nvim_get_runtime_file("", true)
								},
							})
						end,
						settings = {
							Lua = {
								format = {
									enable = true,
									-- Put format options here
									-- NOTE: the value should be STRING!!
									defaultConfig = {
										indent_style = "space",
										indent_size = "2",
									},
								},
							},
						},
					})
				end,
				["basedpyright"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.basedpyright.setup({
						capabilities = capabilities,
						on_attach = function(client, bufnr)
							-- Disable document formatting (use ruff for that)
							client.server_capabilities.document_formatting = false
							-- Disable semantic tokens if you prefer treesitter highlighting
							client.server_capabilities.semanticTokensProvider = nil

							-- Enable inlay hints if supported (Neovim 0.10+)
							if client.supports_method("textDocument/inlayHint") then
								vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
							end
						end,
						settings = {
							basedpyright = {
								analysis = {
									autoSearchPaths = true,
									diagnosticMode = "openFilesOnly", -- Only check open files for better performance
									useLibraryCodeForTypes = true,
									typeCheckingMode = "basic", -- Change to "all" if you want stricter checking
									-- Disable some noisy diagnostics
									diagnosticSeverityOverrides = {
										reportAny = false,
										reportMissingTypeArgument = false,
										reportMissingTypeStubs = false,
										reportUnknownArgumentType = false,
										reportUnknownMemberType = false,
										reportUnknownParameterType = false,
										reportUnknownVariableType = false,
										reportUnusedCallResult = false,
									},
								},
							},
							python = {},
						},
						before_init = function(_, config)
							local python_path = get_python_path()
							config.settings.python.pythonPath = python_path
							-- Optional: notify which Python path is being used
							-- vim.notify("Using Python: " .. python_path)
						end,
					})
				end,

				["ruff"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.ruff.setup({
						capabilities = capabilities,
					})
				end,
			},
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Esc>"] = cmp.mapping.abort(),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			enabled = function()
				local buftype = vim.api.nvim_buf_get_option(0, "buftype")
				-- disable cmp in certain buffer or filetypes
				if buftype == "prompt" then
					return false
				end
				return true
			end,
			sources = cmp.config.sources({
				{ name = "copilot", group_index = 2 },
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		-- Configure sources specifically for markdown files (no buffer suggestions)
		cmp.setup.filetype("markdown", {
			sources = cmp.config.sources({
				{ name = "copilot", group_index = 2 },
				{ name = "luasnip" }, -- For luasnip users (your snippets)
				{ name = "path" }, -- File path completion
			}),
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
