-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
---- Diagnostic keymaps

vim.keymap.set('n', '<leader>dr', ':split | terminal python manage.py runserver<CR>', { desc = '[d]jango manage.py [r]unserver' })

return {
  require 'custom.plugins.none-ls',
}
