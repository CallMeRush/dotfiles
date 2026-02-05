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
  vim.wo.statuscolumn = ""
  vim.wo.signcolumn = "no"
  vim.opt.listchars = { space = "·" }  -- Optional: visualize spaces during setup

  local buf = vim.api.nvim_get_current_buf()

  -- Trim trailing empty lines from content
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  while #lines > 0 and vim.trim(lines[#lines]) == "" do
    table.remove(lines)
  end

  -- Clear buffer before converting to terminal
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

  -- Open terminal channel and send ANSI content
  local chan_id = vim.api.nvim_open_term(buf, { 
    on_input = function(_, _) end  -- No-op to prevent input echo
  })
  vim.api.nvim_chan_send(chan_id, table.concat(lines, "\r\n"))

  -- Buffer-local quit mapping (safer than global)
  local group = vim.api.nvim_create_augroup("AnsiColorize" .. buf, { clear = true })
  vim.keymap.set("n", "q", "<cmd>bd!<cr>", { 
    buffer = buf, 
    silent = true,
    desc = "Quit ANSI viewer"
  })

  -- Position cursor at TOP after terminal fully initializes
  vim.api.nvim_create_autocmd("TermOpen", {
    buffer = buf,
    group = group,
    callback = function()
      vim.cmd("stopinsert")
      vim.cmd("normal! gg")
    end,
  })

  vim.bo[buf].modifiable = false
  vim.bo[buf].readonly = true

  vim.wo.number = true
  vim.wo.relativenumber = true
end
vim.api.nvim_create_user_command('ANSI', function(opts) 
    local success, err = pcall(vim.cmd, "silent! wa")
    ansi_colorize()
end, {})
vim.api.nvim_create_user_command('ANS', function(opts) 
    local success, err = pcall(vim.cmd, "silent! wa")
    ansi_colorize()
end, {})

