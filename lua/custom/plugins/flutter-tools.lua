return {
  'akinsho/flutter-tools.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- Optional: Improved UI for some commands
    'nvim-telescope/telescope.nvim', -- Optional: Fuzzy finding
    'mfussenegger/nvim-dap', -- Optional: Debug Adapter Protocol support
    'neovim/nvim-lspconfig', -- LSP configuration
    'dart-lang/dart-vim-plugin', -- Syntax highlighting and indentation for Dart
  },
  config = function()
    require('flutter-tools').setup {
      ui = {
        border = 'rounded',
      },
      decorations = {
        statusline = {
          app_version = true,
          device = true,
        },
      },
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        highlight = 'Comment',
        prefix = '// ',
        enabled = true,
      },
      dev_log = {
        enabled = true,
        open_cmd = 'tabedit',
      },
      lsp = {
        color = {
          enabled = true,
          background = true,
          virtual_text = true,
        },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          lineLength = 100,
        },
      },
      debugger = {
        enabled = true,
        run_via_dap = true,
      },
    }
  end,
}
