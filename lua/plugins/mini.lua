return {
  'nvim-mini/mini.nvim',
  version = '*',
  config = function()
    require('mini.ai').setup {}
    require('mini.bracketed').setup {}
    require('mini.comment').setup {}
    require('mini.cmdline').setup {
      autocomplete = {
        enable = true,
        map_arrows = true,
      },
    }
    require('mini.cursorword').setup {}
    require('mini.jump').setup {}
    require('mini.jump2d').setup {
      mappings = {
        start_jumping = '<leader>j',
      },
    }
    require('mini.pairs').setup {}
    require('mini.surround').setup {}
    require('mini.trailspace').setup {}

    local hipatterns = require 'mini.hipatterns'
    hipatterns.setup {
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = {
          pattern = '%f[%w]()FIXME()%f[%W]',
          group = 'MiniHipatternsFixme',
        },
        hack = {
          pattern = '%f[%w]()HACK()%f[%W]',
          group = 'MiniHipatternsHack',
        },
        todo = {
          pattern = '%f[%w]()TODO()%f[%W]',
          group = 'MiniHipatternsTodo',
        },
        note = {
          pattern = '%f[%w]()NOTE()%f[%W]',
          group = 'MiniHipatternsNote',
        },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }
  end,
}
