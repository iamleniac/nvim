return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'echasnovski/mini.icons',
  },
  config = function()
    require('mini.icons').mock_nvim_web_devicons()

    require('lualine').setup {}
  end,
}
