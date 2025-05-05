return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'c',
        'cpp',
        'rust',
        'go',
        'lua',
        'python',
        'javascript',
        'typescript',
        'tsx',
        'markdown',
        'jsdoc',
        'vimdoc',
        'vim',
        'ruby',
        'luadoc',
      },
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    }
  end,
}
