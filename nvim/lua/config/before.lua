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

-- Enable ANSI colorization
function ansi_colorize()
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.statuscolumn = ""
  vim.wo.signcolumn = "no"
  vim.opt.listchars = { space = " " }

  local buf = vim.api.nvim_get_current_buf()

  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  while #lines > 0 and vim.trim(lines[#lines]) == "" do
    lines[#lines] = nil
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

  vim.api.nvim_chan_send(vim.api.nvim_open_term(buf, {}), table.concat(lines, "\r\n"))
  vim.keymap.set("n", "q", "<cmd>qa!<cr>", { silent = true, buffer = buf })
  vim.api.nvim_create_autocmd("TextChanged", { buffer = buf, command = "normal! G$" })
  vim.api.nvim_create_autocmd("TermEnter", { buffer = buf, command = "stopinsert" })
end
vim.api.nvim_create_user_command('ANSI', function(opts) 
    local success, err = pcall(vim.cmd, "silent! wa")
    ansi_colorize()
end, {})
vim.api.nvim_create_user_command('ANS', function(opts) 
    local success, err = pcall(vim.cmd, "silent! wa")
    ansi_colorize()
end, {})

