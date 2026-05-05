return {
	{
		"sphamba/smear-cursor.nvim",
		opts = {
			stiffness = 0.8,
			trailing_stiffness = 0.5,
			max_length = 12,
			trailing_expiration_time = 100,
			cursor_color = "#F9E2AF",
		},
	},
	{
		"declancm/cinnamon.nvim",
		opts = {
			keymaps = {
				basic = true,
				extra = true,
			},
			options = {
				delay = 1,
				max_duration = 100,
				min_duration = 50,
				mode = "window",
			},
		},
	},
}
