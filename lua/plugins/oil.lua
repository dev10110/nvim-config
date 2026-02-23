-- oil
return {
	"https://github.com/stevearc/oil.nvim",
	config = function()
		require("oil").setup({
			view_options = {
				show_hidden = true,
			},
		})
	end,
	keys = {
		{ "-", "<Cmd>Oil<CR>", desc = "Browse files from here" },
	},
}
