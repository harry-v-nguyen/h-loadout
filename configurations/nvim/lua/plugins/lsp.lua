return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			-- LSP attach callback for buffer-local keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- -------------------------
					-- Keymaps
					-- -------------------------
					map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
					map("gr", require("telescope.builtin").lsp_references, "Goto References")
					map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
					map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
					map("gh", vim.lsp.buf.hover, "Hover Documentation")
					map("gD", vim.lsp.buf.declaration, "Goto Declaration")

					-- -------------------------
					-- Highlight references under cursor
					-- -------------------------
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup = vim.api.nvim_create_augroup("lsp_highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp_detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "lsp_highlight", buffer = event2.buf })
							end,
						})
					end

					-- -------------------------
					-- Inlay hints toggle
					-- -------------------------
					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "Toggle Inlay Hints")
					end

					-- -------------------------
					-- Organize Go imports on save
					-- -------------------------
					if vim.bo[event.buf].filetype == "go" then
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = event.buf,
							callback = function()
								local params = vim.lsp.util.make_range_params()
								params.context = { only = { "source.organizeImports" } }
								local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
								for _, res in pairs(results or {}) do
									for _, r in pairs(res.result or {}) do
										if r.edit then
											vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
										else
											vim.lsp.buf.execute_command(r.command)
										end
									end
								end
							end,
						})
					end
				end,
			})

			-- Setup capabilities for nvim-cmp
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- LSP servers configuration
			local servers = {
				ols = {
					setup = {
						init_options = {
							checker_args = "-strict-style",
							collections = {
								{ name = "shared", path = vim.fn.expand("$HOME/odin-lib") },
							},
						},
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							completion = { callSnippet = "Replace" },
						},
					},
				},
				intelephense = {
					settings = {
						intelephense = {
							files = {
								maxSize = 5000000,
								associations = { "*.php" },
							},
						},
					},
				},
				ts_ls = {
					root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git"),
				},
				eslint = {
					settings = {
						format = { enable = true },
					},
				},
				pyright = {},
				gopls = {
					settings = {
						gopls = {
							analyses = {
								unusedparams = true,
							},
							staticcheck = true,
							completeUnimported = true,
						},
					},
				},
				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},
				yamlls = {
					settings = {
						yaml = {
							schemas = { ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*" },
							hover = true,
							completion = true,
						},
					},
				},
				html = {},
				cssls = {},
				marksman = {},
				bashls = {},
			}

			-- Ensure Mason tools are installed
			require("mason").setup()
			local ensure_installed = vim.tbl_keys(servers)
			vim.list_extend(ensure_installed, { "stylua" })
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			-- Setup LSP servers via lspconfig
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
			})
		end,
	},
}
