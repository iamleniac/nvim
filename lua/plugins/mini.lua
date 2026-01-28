return {
  'echasnovski/mini.nvim',
  version = false,
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  config = function()
    -- Text editing
    require('mini.ai').setup {}
    require('mini.comment').setup {}
    require('mini.move').setup {}
    require('mini.pairs').setup {}
    require('mini.surround').setup {}

    -- General Workflow
    require('mini.bracketed').setup {}
    require('mini.diff').setup {
      view = {
        style = 'sign',
        signs = {
          add = '+',
          change = '~',
          delete = '_',
        },
      },
    }
    require('mini.jump').setup {}
    require('mini.jump2d').setup {}

    -- Appearance
    require('mini.icons').setup {}
    require('mini.indentscope').setup {}
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
    require('mini.trailspace').setup {}
  end,
}
