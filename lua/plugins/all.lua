return {
	-- colorscheme
	{
		"altercation/vim-colors-solarized",
		lazy = false, -- load immediately
		config = function()
			vim.o.termguicolors = true
			vim.cmd([[colorscheme habamax]])
		end,
	},

	-- -- fuzzy finder
	-- {
	-- 	"https://github.com/junegunn/fzf.vim",
	-- 	dependencies = {
	-- 		"https://github.com/junegunn/fzf",
	-- 	},
	-- 	keys = {
	-- 		{ "<Leader><Leader>", "<Cmd>Files<CR>", desc = "Find files" },
	-- 		{ "<Leader>,", "<Cmd>Buffers<CR>", desc = "Find buffers" },
	-- 		{ "<Leader>/", "<Cmd>Rg<CR>", desc = "Search project" },
	-- 	},
	-- },
	-- oil
	{
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
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "cpp", "julia" },
				highlight = { enable = true },
			})
		end,
	},

	-- auto-pairs
	{
		"https://github.com/windwp/nvim-autopairs",
		event = "InsertEnter", -- Only load when you enter Insert mode
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	-- vim-lastplace
	{
		"https://github.com/farmergreg/vim-lastplace",
		event = "BufReadPost",
	},

	-- status line
	{
		"https://github.com/nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("lualine").setup()
		end,
	},

	-- julia-vim
	{
		"JuliaEditorSupport/julia-vim",
		config = function()
			vim.g.latex_to_unicode_file_types = { "julia", "python", "mail", "markdown", "pandoc", "human" }
		end,
	},

	-- Telescope (for references, symbols, etc.)
	{
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
	},

	--lsp
	{ "mason-org/mason.nvim", tag = "v1.11.0", pin = true },
	{ "mason-org/mason-lspconfig.nvim", tag = "v1.32.0", pin = true },
	{ "neovim/nvim-lspconfig", tag = "v1.8.0", pin = true },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },

	--vim.abolish (helps substitute with case-sensitivity)
	{ "tpope/vim-abolish" },
}
