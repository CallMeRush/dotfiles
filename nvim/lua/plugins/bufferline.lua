return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  options = {
    mode = "buffers",
    show_tab_indicators = true,
    can_close_buffer = true,
    always_show_bufferline = true,
  },
  config = function()
    require("bufferline").setup { }
  end,
}

