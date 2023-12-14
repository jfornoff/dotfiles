-- Fuzzy search for ~everything.
return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'fhill2/telescope-ultisnips.nvim',
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

    telescope.load_extension('ultisnips')

    vim.keymap.set('n', '<leader>f', telescope_builtin.find_files, {})
    vim.keymap.set('n', '<leader>g', telescope_builtin.git_files, {})
    vim.keymap.set('n', '<leader>h', telescope_builtin.buffers, {})
    vim.keymap.set('n', '<leader>j', telescope_builtin.jumplist, {})
    vim.keymap.set('n', '<leader>k', telescope_builtin.keymaps, {})
    vim.keymap.set('n', '<leader>s', telescope.extensions.ultisnips.ultisnips, {})
    vim.keymap.set('n', '\\', telescope_builtin.live_grep, {})
  end
}
