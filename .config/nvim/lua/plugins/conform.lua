return {
  -- Formatter
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      python = { 'ruff_fix', 'ruff_format' },
      lua = { 'stylua' },
      sh = { 'shfmt' },
      typescript = { 'prettier' },
    },
    -- These get passed to the formatter command
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
  init = function()
    local map = require('helpers.keys').map

    map('n', '<leader>cf', function()
      require('conform').format()
    end, '[c]ode [f]ormat')
  end,
}
