return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'stevearc/conform.nvim',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'j-hui/fidget.nvim',
    'folke/neodev.nvim',
    'saghen/blink.cmp',
  },
  init = function()
    vim.g.coq_settings = {
      auto_start = 'shut-up',
    }
  end,
  config = function()
    require('fidget').setup {}
    -- Neodev for neovim config
    require('neodev').setup {}

    -- Conform setup
    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua', 'codespell' },
        typescript = { 'biome-check', 'codespell' },
        javascript = { 'biome-check', 'codespell' },
        typescriptreact = { 'biome-check', 'codespell' },
        javascriptreact = { 'biome-check', 'codespell' },
        json = { 'biome-check', 'codespell' },
        yaml = { 'yamlfmt', 'codespell' },
        html = { 'prettier', 'codespell' },
        ftl = { 'prettier', 'codespell' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
    }

    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(client, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true)
      end

      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

      nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
      nmap('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype definition')
      nmap(
        'gr',
        require('telescope.builtin').lsp_references,
        '[G]oto [R]eferences'
      )
      nmap(
        'gI',
        require('telescope.builtin').lsp_implementations,
        '[G]oto [I]mplementation'
      )
      nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
      nmap(
        '<leader>ds',
        require('telescope.builtin').lsp_document_symbols,
        '[D]ocument [S]ymbols'
      )
      nmap(
        '<leader>ws',
        require('telescope.builtin').lsp_dynamic_workspace_symbols,
        '[W]orkspace [S]ymbols'
      )

      -- See `:help K` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

      vim.keymap.set({ 'v', 'n' }, '=', function()
        vim.lsp.buf.format()
      end)
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

    -- Mason setup
    require('mason').setup()
    require('mason-lspconfig').setup {
      ensure_installed = {
        'tsgo',
        'lua_ls',
        'rust_analyzer',
        'gopls',
        'solargraph',
      },
      handlers = {
        function(server_name)
          vim.lsp.config(server_name, {
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,
        ['lua_ls'] = function()
          vim.lsp.config('lua_ls', {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enabled = false },
              },
            },
          })
        end,
        ['terraform-ls'] = function()
          vim.lsp.config('terraform-ls', {
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { 'terraform' },
          })
        end,
      },
      automatic_installation = false,
    }
  end,
}
