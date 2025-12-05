--- General
-- Print without carriage
vim.keymap.set('n', 'p', function()
  local reg = vim.fn.getreg('+')
  if type(reg) == "string" then
    reg = reg:gsub('\r', '')
    vim.fn.setreg('+', reg)
  end
  vim.cmd('normal! p')
end, { silent = true, desc = "Paste without ^M" })
vim.keymap.set('n', 'P', function()
  local reg = vim.fn.getreg('+')
  if type(reg) == "string" then
    reg = reg:gsub('\r', '')
    vim.fn.setreg('+', reg)
  end
  vim.cmd('normal! P')
end, { silent = true, desc = "Paste before without ^M" })

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

