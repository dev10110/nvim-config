-- Treesitter
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "cpp", "julia" },
			highlight = { enable = true },
		})
	end,
}
