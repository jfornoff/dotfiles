-- Fuzzy search for ~everything.
return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'fhill2/telescope-ultisnips.nvim',
    -- For example for LSP code actions.
    'nvim-telescope/telescope-ui-select.nvim',
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
        },
        layout_strategy = "vertical",
        layout_config = { preview_cutoff = 1, height = 0.99, width = 0.99 }
      },
      extensions = {
        ["ui-select"] = require('telescope.themes').get_cursor()
      }
    })

    telescope.load_extension('ultisnips')
    telescope.load_extension("ui-select")

    vim.keymap.set('n', '<leader>f',
      function() telescope_builtin.find_files({ layout_strategy = "horizontal", layout_config = { preview_height = nil } }) end)
    vim.keymap.set('n', '<leader>g', function() telescope_builtin.git_files({ layout_strategy = "horizontal" }) end)
    vim.keymap.set('n', '<leader>h', telescope_builtin.buffers)
    vim.keymap.set('n', '<leader>j', telescope_builtin.jumplist)
    vim.keymap.set('n', '<leader>k', telescope_builtin.keymaps)
    vim.keymap.set('n', '<leader>sl',
      function() telescope.extensions.ultisnips.ultisnips({ layout_strategy = "horizontal" }) end)
    vim.keymap.set('n', '\\', telescope_builtin.live_grep)
  end
}
