--- Theme
vim.cmd("colorscheme sonokai")

--- Set updatetime such that GitGutter updates on its own
-- vim.opt.updatetime = 500

--- Add treesitter parsers
require('nvim-treesitter').install({ 'rust', 'cpp', 'python' }):wait(300000)

