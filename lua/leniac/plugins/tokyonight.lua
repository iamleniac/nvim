return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require('tokyonight').setup {
      on_colors = function(colors)
        colors.fg_gutter = colors.orange
      end,
    }
    vim.cmd [[colorscheme tokyonight-storm]]
  end,
}
