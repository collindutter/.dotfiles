return {
  -- Find and replace
  'nvim-pack/nvim-spectre',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  init = function()
    local map = require('helpers.keys').map

    map('n', '<leader>fR', function()
      require('spectre').toggle()
    end, '[F]ind and [R]eplace')
  end,
  opts = {
    mapping = {
      ['send_to_qf'] = {
        map = '<C-q>',
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<cr>",
        desc = 'Send all items to quickfix',
      },
    },
  },
}
