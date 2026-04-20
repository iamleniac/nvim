return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  init = function()
    -- Disable entire built-in ftplugin mappings to avoid conflicts.
    -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
    vim.g.no_plugin_maps = true

    -- Or, disable per filetype (add as you like)
    -- vim.g.no_python_maps = true
    -- vim.g.no_ruby_maps = true
    -- vim.g.no_rust_maps = true
    -- vim.g.no_go_maps = true
  end,
  config = function()
    require('nvim-treesitter-textobjects').setup {
      select = {
        enable = true,
        lookahead = true,
      },
    }

    local select = require 'nvim-treesitter-textobjects.select'

    vim.keymap.set({ 'x', 'o' }, 'af', function()
      select.select_textobject('@function.outer', 'textobjects')
    end)

    vim.keymap.set({ 'x', 'o' }, 'if', function()
      select.select_textobject('@function.inner', 'textobjects')
    end)

    vim.keymap.set({ 'x', 'o' }, 'aa', function()
      select.select_textobject('@parameter.outer', 'textobjects')
    end)

    vim.keymap.set({ 'x', 'o' }, 'ia', function()
      select.select_textobject('@parameter.inner', 'textobjects')
    end)
  end,
}
