return {
  'stevearc/oil.nvim',
  dependencies = {
    'nvim-mini/mini.icons',
  },
  config = function()
    require('oil').setup {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      columns = {
        {

          'icon',
        },
      },
      keymaps = {
        ['yp'] = {
          desc = 'copy filepath to system clipboard',
          callback = function()
            require('oil.actions').copy_entry_path.callback()
            vim.fn.setreg('+', vim.fn.getreg(vim.v.register))
          end,
        },
      },
    }

    vim.keymap.set('n', '<leader>pv', '<cmd>Oil<cr>')
  end,
}
