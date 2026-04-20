-- Split screen
vim.keymap.set('n', '<leader>sv', '<C-w>v', { noremap = true })
vim.keymap.set('n', '<leader>sh', '<C-w>s', { noremap = true })

-- Map leader to space
vim.g.mapleader = ' '

-- Map oil to <leader>pv
vim.keymap.set('n', '<leader>pv', '<cmd>Oil<cr>')
