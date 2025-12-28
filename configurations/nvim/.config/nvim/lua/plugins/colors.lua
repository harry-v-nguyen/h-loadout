return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		-- lazy = false,	-- load at startup if this is your main color scheme
		-- priority = 1000,	-- load before other plugins
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = "true",
			})

			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
