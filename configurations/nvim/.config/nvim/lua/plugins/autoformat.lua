return {
	{
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>s",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = {
					templ = true,
				}
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters = {
				odinfmt = { command = "odinfmt", args = { "-stdin" }, stdin = true },
				stylua = { command = "stylua", args = { "-" }, stdin = true },
				black = { command = "black", args = { "--stdin-filename", "%filepath", "-" }, stdin = true },
				isort = { command = "isort", args = { "--stdin-filepath", "%filepath", "-" }, stdin = true },
				prettier = { command = "prettier", args = { "--stdin-filepath", "%filepath" }, stdin = true },
				gofmt = { command = "gofmt", stdin = true },
				clang_format = { command = "clang-format", stdin = true },
			},
			formatters_by_ft = {
				lua = { "stylua" },
				odin = { "odinfmt" },
				python = { "isort", "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				go = { "gofmt" },
				c = { "clang_format" },
				cpp = { "clang_format" },
			},
		},
	},
}
