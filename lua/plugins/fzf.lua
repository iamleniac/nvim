return {
  'ibhagwan/fzf-lua',
  dependencies = {
    'nvim-mini/mini.icons',
  },
  config = function(_, opts)
    local fzf = require 'fzf-lua'
    fzf.setup(opts)
    fzf.register_ui_select()

    require('leniac.keymaps').fzf_keymaps()
  end,
}
