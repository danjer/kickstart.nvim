return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'MeanderingProgrammer/render-markdown.nvim',
    {
      'saghen/blink.cmp',
      lazy = false,
      version = '*',
      opts = {
        keymap = {
          preset = 'enter',
          ['<S-Tab>'] = { 'select_prev', 'fallback' },
          ['<Tab>'] = { 'select_next', 'fallback' },
        },
        cmdline = { sources = { 'cmdline' } },
        sources = {
          default = { 'lsp', 'path', 'buffer', 'codecompanion' },
        },
      },
    },
  },
  config = function()
    -- Register which-key group first
    local wk = require 'which-key'
    wk.register {
      ['<leader>ai'] = { name = '[AI] CodeCompanion' },
    }

    require('codecompanion').setup {
      strategies = {
        chat = {
          adapter = 'anthropic',
          commands = true,
        },
        inline = {
          adapter = 'anthropic',
          commands = true,
        },
      },
      adapters = {
        ollama = function()
          return require('codecompanion.adapters').extend('ollama', {
            env = {
              url = 'http://localhost:11434',
            },
            parameters = {
              sync = true,
            },
          })
        end,
        anthropic = function()
          return require('codecompanion.adapters').extend('anthropic', {
            env = {
              api_key = os.getenv 'ANTHROPIC_API_KEY',
            },
          })
        end,
      },
    }

    -- Define keymaps directly with vim.keymap.set
    vim.keymap.set({ 'n', 'v' }, '<leader>aia', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
    vim.keymap.set({ 'n', 'v' }, '<leader>ait', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
    vim.keymap.set('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })
  end,
}
