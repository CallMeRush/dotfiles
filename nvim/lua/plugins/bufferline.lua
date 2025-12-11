return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup {
      options = {
        mode = "buffers",
        show_tab_indicators = false,
        can_close_buffer = true,
        can_order_buffer = true,
        always_show_bufferline = true,
        numbers = "ordinal",
        pick = {
          alphabet = "123456789",
        },
      }
    }
  end,
}

