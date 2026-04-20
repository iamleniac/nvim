return {
  {
    'folke/trouble.nvim',
    opts = {
      multiline = true,
      win = {
        wo = {
          wrap = true,
          linebreak = true,
        },
      },
    },
    cmd = 'Trouble',
    keys = {
      {
        '<leader>e',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
    },
  },
}
