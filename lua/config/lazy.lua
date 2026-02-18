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
		-- colorscheme
		{
			"altercation/vim-colors-solarized",
			lazy = false, -- load immediately
			config = function()
				vim.o.termguicolors = true
				vim.cmd([[colorscheme habamax]])
			end,
		},

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
		{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("telescope").setup({
          defaults = {
            file_ignore_patterns = { "%.cache/" },
          },
        })
      end,
    },

		--lsp
		{ "mason-org/mason.nvim", tag = "v1.11.0", pin = true },
		{ "mason-org/mason-lspconfig.nvim", tag = "v1.32.0", pin = true },
		{ "neovim/nvim-lspconfig", tag = "v1.8.0", pin = true },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/nvim-cmp" },

    --vim.abolish (helps substitute with case-sensitivity)
    {
      "tpope/vim-abolish",
    }

	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = {
    enabled = true,
    notify = true,
    frequency = 259200,
  },
})

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = "yes"

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities =
	vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

-- -- This is where you enable features that only work
-- -- if there is a language server active in the file
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	desc = "LSP actions",
-- 	callback = function(event)
-- 		local opts = { buffer = event.buf }
--
-- 		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
-- 		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
-- 		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
-- 		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
-- 		vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
-- 		-- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
-- 		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
-- 		vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
-- 		vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
-- 		vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
--
--     -- custom function to use telescope for jumping to references
--     vim.keymap.set("n", "gr", function()
--           require("telescope.builtin").lsp_references( {
--             jump_type = "never",
--           })
--         end, opts)
--
-- 	end,
-- })

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { buffer = event.buf }

    local tb = require("telescope.builtin")

    -- Hover / signature
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)

    -- Navigation (Telescope)
    vim.keymap.set("n", "gd", tb.lsp_definitions, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", tb.lsp_implementations, opts)
    vim.keymap.set("n", "go", tb.lsp_type_definitions, opts)

    -- References (force picker always)
    vim.keymap.set("n", "gr", function()
      tb.lsp_references({ jump_type = "never" })
    end, opts)

    -- Refactoring
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)

    -- Formatting
    vim.keymap.set({ "n", "x" }, "<F3>", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})



require("mason").setup({})
require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,
	},
})

-- auto completion
local cmp = require("cmp")
cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
	},
	preselect = "item",
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	mapping = cmp.mapping.preset.insert({
		-- Navigate between completion items
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = "select" }),

		-- `Enter` key to confirm completion
		["<CR>"] = cmp.mapping.confirm({ select = false }),

		-- Ctrl+Space to trigger completion menu
		["<C-Space>"] = cmp.mapping.complete(),

		-- Scroll up and down in the completion documentation
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
	}),
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
})
