-- split screen
vim.keymap.set('n', '<leader>sv', '<C-w>v', { noremap = true })
vim.keymap.set('n', '<leader>sh', '<C-w>s', { noremap = true })

local M = {}

-- LSP keymaps
M.lsp_keymaps = function()
  local fzf = require 'fzf-lua'
  local actions = require 'fzf-lua.actions'

  -- diagnostics
  vim.keymap.set(
    'n',
    ']d',
    function()
      vim.diagnostic.jump({ count = 1 })
    end,
    { desc = 'Next diagnostic' }
  )
  vim.keymap.set(
    'n',
    ']d',
    function()
      vim.diagnostic.jump({ count = -1 })
    end,
    { desc = 'Prev diagnostic' }
  )

  -- lsp definitions
  vim.keymap.set(
    'n',
    'gd',
    fzf.lsp_definitions,
    { desc = '[G]o to [D]efinition' }
  )
  vim.keymap.set(
    'n',
    'gd',
    function()
      fsp.lsp_definitions({
        actions = { ['default'] = actions.file_vsplit },
        jump_to_single_result = true,
      })
    end,
    { desc = '[G]o to [D]efinition split' }
  )
  vim.keymap.set(
    'n',
    'gt',
    fzf.lsp_typedefs,
    { desc = '[G]o to [T]ype definition' }
  )
  vim.keymap.set(
    'n',
    'gr',
    fzf.lsp_references,
    { desc = '[G]o to [R]eferences' }
  )
  vim.keymap.set(
    'n',
    'gI',
    fzf.lsp_implementations,
    { desc = '[Go] to [I]mplementation' }
  )

  -- documentation
  vim.keymap.set(
    'n',
    'K',
    vim.lsp.buf.hover,
    { desc = 'Hover Documentation' }
  )
  vim.keymap.set(
    'n',
    '<leader>k',
    vim.lsp.buf.signature_help,
    { desc = 'Signature Documentation' }
  )
end

-- FZF keymaps
M.fzf_keymaps = function()
  local fzf = require 'fzf-lua'

  vim.keymap.set('n', '<leader>ff', fzf.files)
  vim.keymap.set('n', '<leader>fg', fzf.live_grep)
  vim.keymap.set(
    'n',
    '<leader>fb',
    fzf.buffers,
    { desc = 'Find existing buffers' }
  )
  vim.keymap.set(
    'n',
    '<leader>/',
    fzf.blines,
    { desc = '[/] Search current buffer' }
  )
end

return M
