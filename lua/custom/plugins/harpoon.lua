return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2', -- Using Harpoon v2
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local harpoon = require 'harpoon'

    -- REQUIRED
    harpoon:setup()

    -- Basic keybindings
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Setup keybindings
    keymap('n', '<leader>ha', function()
      harpoon:list():add()
    end, opts)
    keymap('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, opts)

    -- Navigate through the list sequentially
    keymap('n', '<leader>hn', function()
      harpoon:list():next()
    end, opts)
    keymap('n', '<leader>hp', function()
      harpoon:list():prev()
    end, opts)

    -- Remove current file from Harpoon list
    keymap('n', '<leader>hr', function()
      harpoon:list():remove()
    end, opts)

    -- Remove file at specific index
    keymap('n', '<leader>hd', function()
      local index = vim.fn.input 'Remove which index: '
      harpoon:list():removeAt(tonumber(index))
    end, opts)

    -- Telescope integration
    local telescope_conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = telescope_conf.file_previewer {},
          sorter = telescope_conf.generic_sorter {},
        })
        :find()
    end

    keymap('n', '<leader>hl', function()
      toggle_telescope(harpoon:list())
    end, opts)

    -- Register Harpoon extension for Telescope
    require('telescope').load_extension 'harpoon'
    -- Access with :Telescope harpoon marks
    keymap('n', '<leader>fm', '<cmd>Telescope harpoon marks<CR>', opts)
  end,
}
