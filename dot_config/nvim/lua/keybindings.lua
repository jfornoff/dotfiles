-- Fuzzy navigation
local telescope = require("telescope")
local telescope_builtin = require('telescope.builtin')
local telescope_actions = require("telescope.actions")

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

-- Closing windows quickly
vim.keymap.set('n', '<leader>c', ':ccl<CR>')

-- Remove search highlighting
vim.keymap.set('n', '<C-l>', ':nohlsearch<CR>')

-- Running tests via vim-test
vim.keymap.set('n', '<leader>T', ':TestNearest<CR>')
vim.keymap.set('n', '<leader>t', ':TestFile<CR>')
vim.keymap.set('n', '<leader>a', ':TestSuite<CR>')

-- Global search, provided by fzf.vim
vim.keymap.set('n', '\\', ':Rg<SPACE>')

-- LSP keybindings, if LSP is active.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
    vim.keymap.set('n', '<leader>yd', vim.lsp.buf.definition)
    vim.keymap.set('n', '<leader>yD', vim.lsp.buf.declaration)
    vim.keymap.set('n', '<leader>yf', vim.lsp.buf.references)
    vim.keymap.set('n', '<leader>yr', vim.lsp.buf.rename)
    vim.keymap.set('n', '<leader>ya', vim.lsp.buf.code_action)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  end,
})
