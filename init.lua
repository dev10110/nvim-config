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
