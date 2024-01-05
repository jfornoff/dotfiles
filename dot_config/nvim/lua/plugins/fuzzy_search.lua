-- Fuzzy search for ~everything.
return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'benfowler/telescope-luasnip.nvim',
  },
  config = function()
    local telescope = require('telescope')
    local telescope_builtin = require('telescope.builtin')
    local telescope_actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = telescope_actions.close,
            ["<C-k>"] = telescope_actions.move_selection_previous,
            ["<C-j>"] = telescope_actions.move_selection_next,
          }
        }
      }
    })

    telescope.load_extension('luasnip')

    local dropdown_theme = require('telescope.themes').get_dropdown()
    vim.keymap.set('n', '<leader>f', function() telescope_builtin.find_files(dropdown_theme) end)
    vim.keymap.set('n', '<leader>g', function() telescope_builtin.git_files(dropdown_theme) end)
    vim.keymap.set('n', '<leader>h', function() telescope_builtin.buffers(dropdown_theme) end)
    vim.keymap.set('n', '<leader>j', function() telescope_builtin.jumplist(dropdown_theme) end)
    vim.keymap.set('n', '<leader>k', function() telescope_builtin.keymaps(dropdown_theme) end)
    vim.keymap.set('n', '<leader>s', function() telescope.extensions.luasnip.luasnip(dropdown_theme) end)
    vim.keymap.set('n', '\\', function() telescope_builtin.live_grep(dropdown_theme) end)
  end
}
