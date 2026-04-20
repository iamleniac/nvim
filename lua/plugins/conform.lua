return {
  'stevearc/conform.nvim',
  opts = {},
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        typescript = { 'biome-check' },
        javascript = { 'biome-check' },
        typescriptreact = { 'biome-check' },
        javascriptreact = { 'biome-check' },
        json = { 'biome-check' },
        html = { 'biome-check' },
        css = { 'biome-check' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
    }

    vim.keymap.set({ 'v', 'n' }, '=', function()
      conform.format { lsp_format = 'fallback' }
    end)
  end,
}
