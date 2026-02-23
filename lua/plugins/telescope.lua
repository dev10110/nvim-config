-- Telescope (for references, symbols, etc.)
return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")
		local tb = require("telescope.builtin")

		telescope.setup({
			defaults = {
				file_ignore_patterns = { ".cache" },
			},
		})

		-- keymaps
		vim.keymap.set("n", "<leader><leader>", tb.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>/", tb.live_grep, { desc = "Live grep" })
	end,
}
