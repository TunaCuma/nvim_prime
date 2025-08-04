vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap`a")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.env.TS_SESSION_COMMANDS = "lazygit"

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "ğ", "<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>")
vim.keymap.set("n", "Ğ", "<cmd>silent !tmux neww tmux-sessionizer -s 2<CR>")
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ bufnr = 0 })
end)

-- quickfix and location list
vim.keymap.set("n", "ö", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "π", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>ch", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

vim.keymap.set("n", "<leader>ea", 'oassert.NoError(err, "")<Esc>F";a')

vim.keymap.set("n", "<leader>ef", 'oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\\n", err.Error())<Esc>jj')

vim.keymap.set("n", "<leader>el", 'oif err != nil {<CR>}<Esc>O.logger.Error("error", "error", err)<Esc>F.;i')

vim.keymap.set("n", "<leader>ca", function()
	require("cellular-automaton").start_animation("make_it_rain")
end)

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

-- Save file
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- Copy whole file
vim.keymap.set("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy whole file" })

-- Paste all (select all, paste, then go to end)
vim.keymap.set("n", "<leader>sv", "ggVGpG", { desc = "Paste all" })

-- LSP formatting
--vim.keymap.set("n", "<leader>fm", function()
--  vim.lsp.buf.format { async = true }
--end, { desc = "LSP formatting" })

-- TypeScript Fix All
vim.keymap.set("n", "<leader>tf", function()
	require("core.utils").TypeScriptFixAll()
end, { desc = "Fix TypeScript Issues" })

-- Rename live
-- vim.keymap.set("n", "<leader>rn", "<cmd>IncRename<CR>", { desc = "Rename live" })

-- Toggle comment (normal mode)
vim.keymap.set("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })

-- Toggle comment (visual mode)
vim.keymap.set(
	"v",
	"<leader>/",
	"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ desc = "Toggle comment" }
)

vim.keymap.set("n", "<Esc>", "<cmd> noh <CR>")

vim.keymap.set("n", "<leader>tu", function()
	-- get current file, strip .py, replace / with .
	local file = vim.fn.expand("%:r")
	local module = string.gsub(file, "/", ".")
	local cmd = "uc monolith unittest " .. module
	vim.cmd("split | terminal " .. cmd)
end, { desc = "Run unit test for current module" })

vim.keymap.set("n", "<leader>n", function()
	local curfile = vim.api.nvim_buf_get_name(0)
	local dir = vim.fn.fnamemodify(curfile, ":p:h")
	if dir ~= "" then
		vim.cmd("lcd " .. dir)
	end
	vim.cmd("enew")
end, { desc = "New empty buffer in current file's directory" })

-- new tab
vim.keymap.set("n", "<leader>tn", function()
	local file = vim.api.nvim_buf_get_name(0)
	local dir = vim.fn.fnamemodify(file, ":h")
	vim.cmd("tabnew")
	vim.cmd("tcd " .. vim.fn.fnameescape(dir))
	if file ~= "" then
		vim.cmd("edit " .. vim.fn.fnameescape(file))
	end
end, { noremap = true, silent = true })

-- next tab
vim.keymap.set("n", "<tab>", "<cmd>tabnext<CR>")

-- previous tab
vim.keymap.set("n", "<S-tab>", "<cmd>tabprevious<CR>")

-- close tab
vim.keymap.set("n", "<leader>x", "<cmd>tabclose<CR>")

-- close all tabs
vim.keymap.set("n", "<leader>X", "<cmd>tabonly<CR>")

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

local function get_github_info()
	-- Get relative file path from git root
	local handle = io.popen("git rev-parse --show-toplevel")
	if not handle then
		error("Failed to get git root directory")
	end
	local git_root = handle:read("*a"):gsub("\n", "")
	handle:close()

	local full_path = vim.fn.expand("%:p")
	local file = full_path:gsub("^" .. git_root:gsub("([%(%)%.%+%-%*%?%[%]%^%$%%])", "%%%1") .. "/", "")

	-- Get repo url
	handle = io.popen("git config --get remote.origin.url")
	if not handle then
		error("Failed to get git remote URL")
	end
	local repo_url = handle:read("*a"):gsub("\n", "")
	handle:close()

	-- Clean up repo url
	repo_url = repo_url:gsub("git@github.com:", "https://github.com/")
	repo_url = repo_url:gsub("%.git$", "")
	if not repo_url:match("^https://github.com/") then
		repo_url = repo_url:gsub("^git://github.com/", "https://github.com/")
	end

	-- Get branch
	handle = io.popen("git rev-parse --abbrev-ref HEAD")
	if not handle then
		error("Failed to get git branch")
	end
	local branch = handle:read("*a"):gsub("\n", "")
	handle:close()

	return repo_url, branch, file
end

local function copy_github_link()
	local repo_url, branch, file = get_github_info()
	local line = vim.fn.line(".")
	local url = string.format("%s/blob/%s/%s#L%d", repo_url, branch, file, line)

	vim.fn.setreg("+", url)
	vim.notify("Copied link: " .. url)
end

local function copy_github_link_visual()
	-- Get visual selection range before doing anything else
	local start_line = vim.fn.line("v")
	local end_line = vim.fn.line(".")

	-- Ensure start_line <= end_line
	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end

	local repo_url, branch, file = get_github_info()
	local url = string.format("%s/blob/%s/%s#L%d-L%d", repo_url, branch, file, start_line, end_line)

	vim.fn.setreg("+", url)
	vim.notify("Copied link: " .. url)
end

vim.keymap.set("n", "<leader>gh", copy_github_link, { noremap = true, silent = true })
vim.keymap.set("v", "<leader>gh", copy_github_link_visual, { noremap = true, silent = true })

-- Map the escape sequence to Ctrl+I
vim.keymap.set({ "n", "i", "v" }, "<Esc>[1;5I", "<C-i>", {})
