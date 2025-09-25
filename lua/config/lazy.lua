-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- fuzzy finder
		{
			"https://github.com/junegunn/fzf.vim",
			dependencies = {
				"https://github.com/junegunn/fzf",
			},
			keys = {
				{ "<Leader><Leader>", "<Cmd>Files<CR>", desc = "Find files" },
				{ "<Leader>,", "<Cmd>Buffers<CR>", desc = "Find buffers" },
				{ "<Leader>/", "<Cmd>Rg<CR>", desc = "Search project" },
			},
		},
		-- oil
		{
			"https://github.com/stevearc/oil.nvim",
			config = function()
				require("oil").setup()
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
		{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

		-- LSP + Mason
		{ "neovim/nvim-lspconfig" },
		{ "williamboman/mason.nvim", build = ":MasonUpdate" },
		{ "williamboman/mason-lspconfig.nvim" },

		-- Autocomplete
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "L3MON4D3/LuaSnip" },
		{ "saadparwaiz1/cmp_luasnip" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
