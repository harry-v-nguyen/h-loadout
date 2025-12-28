local conf = require("telescope.config").values
local themes = require("telescope.themes")

-- helper function to fuzzy find inside harpoon list
local function find_harpoon_list(harpoon_list)
	local file_paths = {}
	for _, item in ipairs(harpoon_list.items) do
		table.insert(file_paths, item.value)
	end
	local opts = themes.get_ivy({
		prompt_title = "Fuzzy find in Harpoon list",
	})

	require("telescope.pickers")
		.new(opts, {
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer(opts),
			sorter = conf.generic_sorter(opts),
		})
		:find()
end

-- helper function to fuzzy grep inside harpoon list
local function grep_harpoon_list(harpoon_list)
	local list = {}
	for _, item in ipairs(harpoon_list.items) do
		table.insert(list, item.value)
	end

	if #list == 0 then
		vim.notify("Harpoon list is empty", vim.log.levels.WARN)
		return
	end

	require("telescope.builtin").live_grep({
		prompt_title = "Fuzzy grep in Harpoon list",
		search_dirs = list,
	})
end

return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			vim.keymap.set("n", "<leader>e", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)
			vim.keymap.set("n", "<leader>fl", function()
				find_harpoon_list(harpoon:list())
			end, { desc = "Fuzzy find in Harpoon list" })
			vim.keymap.set("n", "<leader>fe", function()
				grep_harpoon_list(harpoon:list())
			end, { desc = "Fuzzy grep in Harpoon list" })
			vim.keymap.set("n", "<C-p>", function()
				harpoon:list():prev()
			end)
			vim.keymap.set("n", "<C-n>", function()
				harpoon:list():next()
			end)
		end,
	},
}
