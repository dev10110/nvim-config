-- colorscheme
return {
	"altercation/vim-colors-solarized",
	lazy = false, -- load immediately
	config = function()
		vim.o.termguicolors = true
		vim.cmd([[colorscheme habamax]])
	end,
}
