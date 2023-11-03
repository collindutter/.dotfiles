vim.opt.viewoptions:remove 'curdir' -- disable saving current directory with views
vim.opt.shortmess:append { s = true, I = true } -- disable search count wrap and startup messages
vim.opt.backspace:append { 'nostop' } -- don't stop backspace at insert
vim.opt.diffopt:append 'linematch:60' -- enable linematch diff algorithm
local options = {
  opt = {
    breakindent = true, -- wrap indent to match  line start
    clipboard = 'unnamedplus', -- connection to the system clipboard
    completeopt = { 'menu', 'menuone', 'noselect' }, -- Options for insert mode completion
    copyindent = true, -- copy the previous indentation on autoindenting
    cursorline = true, -- highlight the text line of the cursor
    expandtab = true, -- enable the use of space in tab
    fillchars = { eob = ' ' }, -- disable `~` on nonexistent lines
    history = 100, -- number of commands to remember in a history table
    ignorecase = true, -- case insensitive searching
    infercase = true, -- infer cases in keyword completion
    laststatus = 3, -- global statusline
    linebreak = true, -- wrap lines at 'breakat'
    mouse = 'a', -- enable mouse support
    number = true, -- show numberline
    preserveindent = true, -- preserve indent structure as much as possible
    pumheight = 10, -- height of the pop up menu
    relativenumber = true, -- show relative numberline
    shiftwidth = 2, -- number of space inserted for indentation
    showmode = false, -- disable showing modes in command line
    signcolumn = 'yes', -- always show the sign column
    showcmd = false, -- don't show pending commands in bottom right
    cmdheight = 1, -- height of the command line
    smartcase = true, -- case sensitive searching
    splitbelow = true, -- splitting a new window below the current one
    splitright = true, -- splitting a new window at the right of the current one
    tabstop = 2, -- number of space in a tab
    termguicolors = true, -- enable 24-bit RGB color in the TUI
    timeoutlen = 500, -- shorten key timeout length a little bit for which-key
    undofile = true, -- enable persistent undo
    updatetime = 300, -- length of time to wait before triggering the plugin
    virtualedit = 'block', -- allow going past end of line in visual block mode
    wrap = false, -- disable wrapping of lines longer than the width of window
    writebackup = false, -- disable making a backup before overwriting a file,
  },
  g = {
    python3_host_prog = '~/.virtualenvs/py3nvim/bin/python', -- set python provider
  },
}

for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end

