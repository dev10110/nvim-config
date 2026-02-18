vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.undofile = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 0 -- set to 0 to default to tabstop value

-- install lazy
require("config.lazy")

-- -- clang-format on save
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = {"*.c", "*.cpp", "*.h", "*.hpp"},
--     callback = function()
--         local bufname = vim.api.nvim_buf_get_name(0)
--         vim.fn.jobstart({"clang-format", "-i", bufname}, {
--             on_exit = function() vim.cmd("edit") end
--         })
--     end,
-- })
--

-- strip trailing whitespaces
vim.cmd([[
  " Function to strip trailing whitespace "
  fun! StripTrailingWhitespace()
    " Only strip if the b:noStripWhitespace variable isn't set
    if exists('b:noStripWhitespace')
      return
    endif
    %s/\s\+$//e
    %s#\($\n\s*\)\+\%$##e
  endfun

  " Run StripTrailingWhitespace() on BufWritePre
  autocmd BufWritePre * call StripTrailingWhitespace()
]])
