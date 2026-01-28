local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_blink, blink = pcall(require, 'blink.cmp')

if has_blink then
  capabilities = blink.get_lsp_capabilities(capabilities)
end

local on_attach = function(client, _)
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true)
  end

  vim.diagnostic.config({ virtual_text = true })

  require('leniac.keymaps').lsp_keymaps()
end

local function mason_cmd(bin, args)
  local cmd = { vim.fn.stdpath('data') .. '/mason/bin/' .. bin }

  if args then
    vim.list_extend(cmd, args)
  end

  return cmd
end

local servers = {
  lua_ls = {
    cmd = mason_cmd('lua-language-server'),
    settings = {
      Lua = {
        telemetry = { enabled = false }
      }
    },
    filetypes = {
      'lua'
    }
  },
  tsgo = {
    cmd = mason_cmd('tsgo', {
      '--lsp',
      '--stdio'
    }),
    filetypes = {
      'javascript', 'javascriptreact', 'typescript', 'typescriptreact'
    }
  },
  biome = {
    cmd = mason_cmd('biome', { 'lsp-proxy' }),
    filetypes = {
      'javascript', 'javascriptreact', 'typescript', 'typescriptreact'
    }
  }
}

for server, cfg in pairs(servers) do
  vim.lsp.config(server, {
    cmd = cfg.cmd,
    capabilities = capabilities,
    on_attach = on_attach,
    settings = cfg.settings,
    filetypes = cfg.filetypes
  })

  vim.lsp.enable(server)
end
