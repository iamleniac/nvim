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
        typescript = { 'biome', 'codespell' },
        javascript = { 'biome', 'codespell' },
        typescriptreact = { 'biome', 'codespell' },
        javascriptreact = { 'biome', 'codespell' },
        json = { 'biome', 'codespell' },
        yaml = { 'yamlfmt', 'codespell' },
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

    -- Mason setup
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
    local nvim_lsp = require 'lspconfig'
    require('mason').setup()
    require('mason-lspconfig').setup {
      ensure_installed = {
        'lua_ls',
        'rust_analyzer',
        'gopls',
        'ts_ls',
        'solargraph',
        'denols',
      },
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
          }
        end,
        ['lua_ls'] = function()
          nvim_lsp.lua_ls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                runtime = { version = 'Lua 5.1' },
                workspace = { checkThirdParty = false },
                telemetry = { enabled = false },
              },
            },
          }
        end,
        ['denols'] = function()
          nvim_lsp.denols.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            root_dir = nvim_lsp.util.root_pattern('deno.json', 'deno.jsonc'),
          }
        end,
        ['tailwindcss'] = function()
          nvim_lsp.tailwindcss.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { 'javascriptreact', 'typescriptreact' },
          }
        end,
        ['ts_ls'] = function()
          nvim_lsp.ts_ls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            root_dir = nvim_lsp.util.root_pattern 'package.json',
          }
        end,
      },
      automatic_installation = false,
    }
  end,
}
