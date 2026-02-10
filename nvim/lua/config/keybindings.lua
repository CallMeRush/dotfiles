--- General
-- Change leader from "\" to " "
vim.g.mapleader = " "
-- Print without carriage "\r" or "^M"
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
-- Close folder tree
vim.keymap.set('n', '<C-p>', ':NvimTreeClose<CR>', { noremap = true, silent = true })

--- aerial
-- Focus outline tree
vim.keymap.set('n', '<leader>o', ':AerialOpen<CR>', { noremap = true, silent = true })
-- Close outline tree
vim.keymap.set('n', '<leader>p', ':AerialClose<CR>', { noremap = true, silent = true })

--- Handle windows and buffers
-- Split window vertically and horizontally
vim.keymap.set('n', '<leader>\\', ':vsplit<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>|', ':split<CR>', { noremap = true, silent = true })
-- Switch between windows
vim.keymap.set('n', '<C-h>', ':winc h<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', ':winc j<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', ':winc k<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', ':winc l<CR>', { noremap = true, silent = true })
-- Switch to indexed buffer
vim.keymap.set('n', '<leader>1', ':BufferLinePick<CR>1', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>2', ':BufferLinePick<CR>2', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>3', ':BufferLinePick<CR>3', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>4', ':BufferLinePick<CR>4', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>5', ':BufferLinePick<CR>5', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>6', ':BufferLinePick<CR>6', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>7', ':BufferLinePick<CR>7', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>8', ':BufferLinePick<CR>8', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>9', ':BufferLinePick<CR>9', { noremap = true, silent = true })

--- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

--- nvim-origami
vim.keymap.set("n", "H", function() vim.cmd("normal! 0") require("origami").h() end)
vim.keymap.set("n", "L", function() require("origami").l() end)

