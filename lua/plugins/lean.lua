return {
  'Julian/lean.nvim',
  event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

  dependencies = {
    -- optional dependencies:

    -- 'nvim-telescope/telescope.nvim', -- for Lean-specific pickers
    -- 'andymass/vim-matchup',          -- for enhanced % motion behavior
    -- 'andrewradev/switch.vim',        -- for switch support
    -- 'tomtom/tcomment_vim',           -- for commenting
  },

  -- lean.nvim no longer needs `setup()`; it activates itself on Lean files.
  -- Configuration goes in `vim.g.lean_config`, which must be set before the
  -- plugin loads -- hence `init` rather than `opts`/`config`.
  init = function()
    ---@type lean.Config
    vim.g.lean_config = {
      mappings = true,
    }
  end,
}
