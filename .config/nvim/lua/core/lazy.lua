-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local ok, lazy = pcall(require, 'lazy')
if not ok then
  return
end

lazy.setup {
  spec = {
    { import = 'plugins' },
  },
  ui = {
    border = 'rounded',
  },
  change_detection = {
    notify = false,
  },
  defaults = {
    lazy = false,
  },
  install = {
    colorscheme = { 'catppuccin' },
  },
}

require('helpers.keys').map('n', '<leader>L', lazy.show, 'Show [L]azy')
