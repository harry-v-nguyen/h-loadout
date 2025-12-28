return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		autotag = { enable = true },
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"markdown_inline",
			"go",
			"gomod",
			"gosum",
			"gowork",
			"templ",
		},
		auto_install = false,
	},
}
