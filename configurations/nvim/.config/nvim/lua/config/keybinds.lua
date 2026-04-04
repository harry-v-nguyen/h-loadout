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

-- open up in-line syntax messsages
vim.keymap.set("n", "<leader>d", function()
  local float_buf, _ = vim.diagnostic.open_float()
  
  if not float_buf or not vim.api.nvim_buf_is_valid(float_buf) then return end
  
  vim.defer_fn(function()
    local lines = vim.api.nvim_buf_get_lines(float_buf, 0, -1, false)
    if #lines > 0 then
      local text = table.concat(lines, "\n")
      vim.fn.setreg("+", text)
      -- 5. Close the buffer (and its window) immediately after copying
      vim.api.nvim_buf_delete(float_buf, { force = true })
      print("Diagnostic copied and window closed!")
    end
  end, 10)
end, opts)
