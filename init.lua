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

vim.keymap.set("v", "<leader>c", '"+y')
vim.keymap.set("v", "<leader>v", '"+p')
vim.keymap.set("n", "<leader>v", '"+p')

-- Copy just the file name
vim.keymap.set("n", "<leader>cf", '<cmd>let @+ = expand("%:t")<CR>', { desc = "Copy file name" })
-- Copy the relative path
vim.keymap.set("n", "<leader>cr", '<cmd>let @+ = expand("%")<CR>', { desc = "Copy relative path" })
-- Copy the absolute path
vim.keymap.set("n", "<leader>ca", '<cmd>let @+ = expand("%:p")<CR>', { desc = "Copy absolute path" })


-- Automatically configure makeprg for CMake projects
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" }, -- Triggers for C and C++ files
  callback = function()
    -- Checks if a CMakeLists.txt file exists in the root directory
    if vim.fn.filereadable("CMakeLists.txt") == 1 then
      vim.opt_local.makeprg = "cmake --build build"

      -- Clear any old directory hooks since we no longer 'cd'
      -- vim.opt_local.errorformat:prepend("%D")

      -- Filter out Ninja/CMake tracking logs to keep quickfix window clean
      -- vim.opt_local.errorformat:append([[:-G\[%*\\d/%*\\d\]\ %*\\s%f%*\\s]])

    end
  end,
})

-- Convenient keymap to build and open errors
vim.keymap.set('n', '<Leader>b', ':make | copen<CR>', { silent = true, desc = "Run CMake Build" })
