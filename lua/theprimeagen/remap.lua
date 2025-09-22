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
vim.keymap.set("n", "<C-c>", function()
	local pos = vim.api.nvim_win_get_cursor(0)

	-- Go to beginning
	vim.api.nvim_win_set_cursor(0, { 1, 0 })

	local first_line = vim.api.nvim_get_current_line()
	if first_line:match("^---") then
		-- Use vim.fn.search to find closing ---
		local found = vim.fn.search("^---$", "W")
		if found > 0 then
			vim.cmd("normal! 2j") -- Move to next line
			vim.cmd('normal! VG"+y') -- Select to end and copy
		else
			vim.cmd("%y+") -- Fallback to whole file
		end
	else
		vim.cmd("%y+")
	end

	-- Restore position
	vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "Copy whole file (skip frontmatter)" })

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

	-- Clean up repo url - handle various SSH formats
	-- Handle standard SSH format: git@github.com:user/repo.git
	repo_url = repo_url:gsub("git@github%.com:", "https://github.com/")
	-- Handle org-prefixed SSH format: org-123@github.com:user/repo.git
	repo_url = repo_url:gsub(".*@github%.com:", "https://github.com/")
	-- Remove .git suffix
	repo_url = repo_url:gsub("%.git$", "")
	-- Handle git:// protocol
	if not repo_url:match("^https://github.com/") then
		repo_url = repo_url:gsub("^git://github.com/", "https://github.com/")
	end

	-- Get branch (handle detached HEAD)
	handle = io.popen("git rev-parse --abbrev-ref HEAD")
	if not handle then
		error("Failed to get git branch")
	end
	local branch = handle:read("*a"):gsub("\n", "")
	handle:close()

	-- If in detached HEAD state, get the commit hash instead
	if branch == "HEAD" then
		handle = io.popen("git rev-parse HEAD")
		if not handle then
			error("Failed to get git commit hash")
		end
		branch = handle:read("*a"):gsub("\n", "")
		handle:close()
	end

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
-- Add this to your Neovim configuration (init.lua or a separate lua file)

-- Function to convert selected text to markdown link using clipboard content
local function selection_to_markdown_link()
	-- Save the current clipboard content
	local clipboard_content = vim.fn.getreg("+")

	-- Check if clipboard has content
	if not clipboard_content or clipboard_content == "" then
		vim.notify("Clipboard is empty", vim.log.levels.WARN)
		return
	end

	-- Get visual selection information
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")

	-- Ensure we're working with valid positions
	if not start_pos or not end_pos then
		vim.notify("Could not get selection positions", vim.log.levels.ERROR)
		return
	end

	local start_line = start_pos[2]
	local start_col = start_pos[3]
	local end_line = end_pos[2]
	local end_col = end_pos[3]

	-- Only handle single-line selections
	if start_line ~= end_line then
		vim.notify("Multi-line selections are not supported", vim.log.levels.WARN)
		return
	end

	-- Get the line content
	local line = vim.api.nvim_buf_get_lines(0, start_line - 1, start_line, false)[1]

	if not line then
		vim.notify("Could not get line content", vim.log.levels.ERROR)
		return
	end

	-- Handle visual mode column positions (1-indexed, byte-indexed)
	-- In visual mode, end_col might need adjustment for inclusive selection
	local mode = vim.fn.mode()
	if mode == "v" or mode == "V" then
		-- Visual mode is inclusive, so we need to include the character at end_col
		end_col = end_col + 1
	end

	-- Extract parts of the line
	local before = string.sub(line, 1, start_col - 1)
	local selected = string.sub(line, start_col, end_col - 1)
	local after = string.sub(line, end_col)

	-- Validate that we got the selected text
	if not selected or selected == "" then
		vim.notify("No text selected", vim.log.levels.WARN)
		return
	end

	-- Create the markdown link
	local markdown_link = string.format("[%s](%s)", selected, clipboard_content)

	-- Reconstruct the line
	local new_line = before .. markdown_link .. after

	-- Replace the line
	vim.api.nvim_buf_set_lines(0, start_line - 1, start_line, false, { new_line })

	-- Calculate cursor position (place it after the closing parenthesis)
	local new_cursor_col = start_col + string.len(markdown_link) - 1
	vim.api.nvim_win_set_cursor(0, { start_line, new_cursor_col })

	-- Exit visual mode
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end

-- Create the keymap for visual mode
vim.keymap.set("v", "<leader>ml", function()
	-- Store the visual selection marks before calling the function
	vim.cmd("normal! gv")
	-- Give a small delay to ensure marks are set
	vim.defer_fn(function()
		selection_to_markdown_link()
	end, 0)
end, { desc = "Convert selection to markdown link using clipboard URL" })

vim.keymap.set("n", "<leader>r", function()
	-- Save the original window
	local original_win = vim.api.nvim_get_current_win()

	-- Get the current file path
	local file_path = vim.fn.expand("%:p")
	-- Check if it's a Python file
	if vim.fn.expand("%:e") ~= "py" then
		print("Not a Python file")
		return
	end

	-- Create or reuse a buffer for output
	local buf_name = "Python Output"
	local existing_buf = nil

	-- Check if output buffer already exists
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf):match(buf_name) then
			existing_buf = buf
			break
		end
	end

	-- Create new buffer if it doesn't exist
	if not existing_buf then
		existing_buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_name(existing_buf, buf_name)
	end

	-- Check if buffer is already visible in a window
	local existing_win = nil
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_buf(win) == existing_buf then
			existing_win = win
			break
		end
	end

	-- Only create new split if buffer isn't already visible
	if not existing_win then
		vim.cmd("rightbelow vsplit")
		vim.api.nvim_win_set_buf(0, existing_buf)
		existing_win = vim.api.nvim_get_current_win()
	end

	-- Clear the buffer
	vim.api.nvim_buf_set_lines(existing_buf, 0, -1, false, {})

	-- Run Python file and capture output
	local cmd = "python " .. vim.fn.shellescape(file_path)
	vim.fn.jobstart(cmd, {
		stdout_buffered = true,
		stderr_buffered = true,
		on_stdout = function(_, data)
			if data then
				vim.api.nvim_buf_set_lines(existing_buf, -1, -1, false, data)
			end
		end,
		on_stderr = function(_, data)
			if data then
				-- Add stderr with error prefix
				local error_lines = {}
				for _, line in ipairs(data) do
					if line ~= "" then
						table.insert(error_lines, "ERROR: " .. line)
					end
				end
				vim.api.nvim_buf_set_lines(existing_buf, -1, -1, false, error_lines)
			end
		end,
		on_exit = function(_, code)
			local status_line = { "", "--- Exit code: " .. code .. " ---" }
			vim.api.nvim_buf_set_lines(existing_buf, -1, -1, false, status_line)
		end,
	})

	-- Return focus to original window
	vim.api.nvim_set_current_win(original_win)
end, { desc = "Run current Python file" })
