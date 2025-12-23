--- General config

-- Use system-wide clipboard
vim.opt.clipboard = "unnamedplus"

-- Show numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Edit tab key
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Disable mouse
vim.opt.mouse = "a"
vim.keymap.set("n", "<LeftMouse>", "<NOP>", { noremap = true, silent = true })
vim.keymap.set("i", "<LeftMouse>", "<NOP>", { noremap = true, silent = true })

