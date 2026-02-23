-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      actions = {
        open_file = {
          quit_on_open = true,
            window_picker = {
	          enable = true,
              chars = "123456789",
            },
        },
      },
      git = {
        ignore = false;
      },
    }
  end,
}

