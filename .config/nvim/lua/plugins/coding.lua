-- Plugins that impact typing code
return {
  {
    -- Surround motions
    'kylechui/nvim-surround',
    version = '*',
    event = 'BufEnter',
    opts = {},
  },
  {
    -- Comment visual regions/lines
    'numToStr/Comment.nvim',
    event = 'BufEnter',
    opts = {},
  },
  {
    -- Move by subwords
    'chrisgrieser/nvim-spider',
    opts = { skipInsignificantPunctuation = false },
    keys = {
      {
        'w',
        function()
          require('spider').motion 'w'
        end,
        desc = 'Spider w',
        mode = { 'n', 'o', 'x' },
      },
      {
        'e',
        function()
          require('spider').motion 'e'
        end,
        desc = 'Spider e',
        mode = { 'n', 'o', 'x' },
      },
      {
        'b',
        function()
          require('spider').motion 'b'
        end,
        desc = 'Spider b',
        mode = { 'n', 'o', 'x' },
      },
      {
        'ge',
        function()
          require('spider').motion 'ge'
        end,
        desc = 'Spider ge',
        mode = { 'n', 'o', 'x' },
      },
    },
    init = function()
      vim.keymap.set({ 'n', 'o', 'x' }, 'cw', 'ce', { desc = 'Spider-ce', remap = true })
    end,
  },
  {
    -- Easy motion
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = { modes = { search = { enabled = false } } },
    keys = {
      {
        's',
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
        mode = { 'n', 'x', 'o' },
      },
      {
        'S',
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
        mode = { 'n', 'x', 'o' },
      },
    },
  },
  {
    {
      -- Autocompletion
      'hrsh7th/nvim-cmp',
      dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',

        -- LSP completion capabilities
        'hrsh7th/cmp-nvim-lsp',

        -- Copilot
        'zbirenbaum/copilot.lua',
      },
      config = function()
        local cmp = require 'cmp'
        local copilot_suggestion = require 'copilot.suggestion'
        local luasnip = require 'luasnip'
        require('luasnip.loaders.from_vscode').lazy_load()
        luasnip.config.setup {}

        local function has_words_before()
          local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
        end

        local border_opts = {
          border = 'rounded',
        }

        cmp.setup {
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          },
          mapping = cmp.mapping.preset.insert {
            ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
            ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true }
                cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true }
              elseif copilot_suggestion.is_visible() then
                copilot_suggestion.accept()
              elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end, { 'i', 's' }),
          },
          sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
          },
          window = {
            completion = cmp.config.window.bordered(border_opts),
            documentation = cmp.config.window.bordered(border_opts),
          },
        }
      end,
      event = 'InsertEnter',
    },
  },
  {
    -- Copilot
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    init = function()
      -- Hide copilot suggestions when cmp menu is open
      -- to prevent odd behavior/garbled up suggestions
      local cmp_status_ok, cmp = pcall(require, 'cmp')
      if cmp_status_ok then
        cmp.event:on('menu_opened', function()
          vim.b.copilot_suggestion_hidden = true
        end)

        cmp.event:on('menu_closed', function()
          vim.b.copilot_suggestion_hidden = false
        end)
      end
    end,
    opts = {
      panel = { enabled = false },
      suggestion = {
        auto_trigger = true,
        accept = false,
      },
      filetypes = { yaml = true, markdown = true, help = true },
    },
  },
  {
    -- Autopair quotes, brackets, etc
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
}
