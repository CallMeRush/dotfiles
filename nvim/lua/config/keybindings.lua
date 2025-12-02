--- nvim-tree
-- Focus folder tree
vim.keymap.set('n', '<C-o>', ':NvimTreeFocus<CR>', { noremap = true, silent = true })
-- Focus folder tree
vim.keymap.set('n', '<C-p>', ':NvimTreeClose<CR>', { noremap = true, silent = true })

--- Switch between buffers
-- Next buffet
vim.keymap.set('n', '<C-l>', ':bn<CR>', { noremap = true, silent = true })
-- Previous buffet
vim.keymap.set('n', '<C-h>', ':bp<CR>', { noremap = true, silent = true })

