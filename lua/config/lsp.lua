vim.diagnostic.config { virtual_text = true }

local on_attach = function(client, _)
  if client.server_capabilities.inlayHintProvider then
    -- Toggle inlay hints
    vim.keymap.set('n', '<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end)
  end

  local fzf = require 'fzf-lua'
  local actions = require 'fzf-lua.actions'

  vim.keymap.set('n', 'gd', fzf.lsp_definitions)

  vim.keymap.set('n', 'gs', function()
    fzf.lsp_definitions {
      actions = { ['default'] = actions.file_vsplit },
      jump_to_single_result = true,
    }
  end)

  vim.keymap.set('n', 'gt', fzf.lsp_typedefs)

  vim.keymap.set('n', 'gr', fzf.lsp_references)

  vim.keymap.set('n', 'gi', fzf.lsp_implementations)

  vim.keymap.set('n', 'K', vim.lsp.buf.hover)

  vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help)
end

vim.lsp.config('*', {
  on_attach = on_attach,
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

vim.lsp.config('gopls', {
  settings = {
    gopls = {
      buildFlags = { '-tags=integration,e2e,debug' },
    },
  },
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function()
    vim.treesitter.start()
  end,
})
