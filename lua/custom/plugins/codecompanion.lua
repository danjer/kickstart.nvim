return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'MeanderingProgrammer/render-markdown.nvim', -- Add this plugin for markdown rendering
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
    -- Set up the codecompanion.nvim with Ollama adapter
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
              url = 'http://localhost:11434', -- Ollama server URL
            },
            parameters = {
              sync = true, -- Optional: sync mode for request
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
      keymaps = {
        -- Chat toggles and navigation
        ['<leader>cc'] = { ':CodeCompanionToggle<CR>', 'Toggle chat window' },
        ['<leader>ch'] = { ':CodeCompanionHistory<CR>', 'View chat history' },

        -- Code actions
        ['<leader>cs'] = { ':CodeCompanionChat<CR>', 'Send selection to chat', mode = { 'v' } },
        ['<leader>cf'] = { ':CodeCompanionFile<CR>', 'Send file to chat' },

        -- Code generation and analysis
        ['<leader>ci'] = { ':CodeCompanionInline<CR>', 'Generate inline completion', mode = { 'n', 'v' } },
        ['<leader>cr'] = { ':CodeCompanionReview<CR>', 'Review selected code', mode = { 'v' } },
        ['<leader>ct'] = { ':CodeCompanionTest<CR>', 'Generate unit tests', mode = { 'v' } },
        ['<leader>cx'] = { ':CodeCompanionExplain<CR>', 'Explain code', mode = { 'v' } },
      },
    }
  end,
}
