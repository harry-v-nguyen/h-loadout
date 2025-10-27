vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex, opts)

-- WSL system clipboard
local is_wsl = vim.fn.has("wsl") == 1

if is_wsl then
	-- Resolve the path to win32yank.exe relative to your repo
	local nvim_dir = vim.fn.expand("~/.config/nvim/") -- symlinked nvim config
	local repo_config_dir = vim.fn.fnamemodify(nvim_dir, ":h") -- one level up to configurations/
	local win32yank = repo_config_dir .. "/win32yank.exe"

	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = win32yank .. " -i --crlf",
			["*"] = win32yank .. " -i --crlf",
		},
		paste = {
			["+"] = win32yank .. " -o --lf",
			["*"] = win32yank .. " -o --lf",
		},
		cache_enabled = 0,
	}
end

-- Use system clipboard for all normal operations
vim.opt.clipboard = "unnamedplus"

-- copy to and paste from register a
vim.keymap.set("v", "<leader>y", '"ay', opts)
vim.keymap.set("n", "<leader>yy", '"ayy', opts)
vim.keymap.set("v", "<leader>d", '"ad', opts)
vim.keymap.set("n", "<leader>dd", '"add', opts)
vim.keymap.set("v", "<leader>p", '"_d"ap', opts)
vim.keymap.set("v", "<leader>P", '"_d"aP', opts)
vim.keymap.set("n", "<leader>p", '"ap', opts)
vim.keymap.set("n", "<leader>P", '"aP', opts)

-- beginning and end of line
vim.keymap.set({ "n", "v", "o" }, "<leader>i", "0", opts)
vim.keymap.set({ "n", "v", "o" }, "<leader>a", "$", opts)
