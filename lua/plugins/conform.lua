return {
  'stevearc/conform.nvim',
  config = function()
    local conform = require 'conform'

    conform.setup {
      default_format_opts = {
        lsp_format = 'fallback',
      },
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
