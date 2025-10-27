return {
	--    { -- ssh tunneling and copying to clipboard
	-- "ojroques/vim-oscyank",
	--    },
	--    { -- git plugin
	-- "tpope/vim-fugitive",
	--    },
	{ -- show css colors
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({})
		end,
	},
	{ -- automatic spacing and indenting
		"tpope/vim-sleuth",
	},
	{ -- for json lsp
		"b0o/schemastore.nvim",
	},
}
