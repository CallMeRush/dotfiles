return {
  'stevearc/aerial.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = {
     "nvim-treesitter/nvim-treesitter",
     "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("aerial").setup {
      layout = {
        max_width = {60, 0.2},
        min_width = {40, 0.2},
      },
      disable_max_lines = 30000,
      filter_kind = false,
      highlight_on_hover = true,
      autojump = true,
      manage_folds = true,
    }
  end,
}

