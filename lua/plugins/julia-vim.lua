-- julia-vim
return {
	"JuliaEditorSupport/julia-vim",
	config = function()
		vim.g.latex_to_unicode_file_types = {
			"julia",
			"python",
			"mail",
			"markdown",
			"pandoc",
			"human",
		}
	end,
}
