vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

-- vim.keymap.set("n", "<leader>cd", vim.cmd.Ex, opts) -- replacing this with oil

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
