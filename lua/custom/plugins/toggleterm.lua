return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      -- Default toggle mapping
      open_mapping = [[<C-\>]],
      direction = 'horizontal',
    }

    -- Add keymaps for navigating from terminal mode
    function _G.set_terminal_keymaps()
      local opts = { noremap = true }
      -- Escape terminal mode
      vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
      -- Window navigation from terminal
      vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
    end

    -- Auto-apply terminal keymaps when entering terminal mode
    vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

    -- Optional: Add keymaps for numbered terminals
    local Terminal = require('toggleterm.terminal').Terminal
    for i = 1, 3 do
      vim.api.nvim_set_keymap('n', '<leader>' .. i, string.format('<cmd>%dToggleTerm<CR>', i), { noremap = true, silent = true })
    end
  end,
}
