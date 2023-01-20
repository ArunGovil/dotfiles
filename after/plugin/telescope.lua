local builtin = require("telescope.builtin")

require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "node_modules", "android", "ios" },
	},
	pickers = {
		find_files = {
			disable_devicons = true,
		},
	},
})

vim.keymap.set("n", "<leader>f", function()
	builtin.find_files({
		no_ignore = false,
		hidden = false,
	})
end)

vim.keymap.set("n", "<leader>g", function()
	builtin.live_grep()
end)
