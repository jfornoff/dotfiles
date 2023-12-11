-- FZF navigation
vim.keymap.set('n', '<leader>f', ':GitFiles<CR>')
vim.keymap.set('n', '<leader>F', ':Files<CR>')
vim.keymap.set('n', '<leader>h', ':Buffers<CR>')

-- Closing windows quickly
vim.keymap.set('n', '<leader>c', ':ccl<CR>')

-- Remove search highlighting
vim.keymap.set('n', '<C-l>', ':nohlsearch<CR>')

-- Running tests via vim-test
vim.keymap.set('n', '<leader>T', ':TestNearest<CR>')
vim.keymap.set('n', '<leader>t', ':TestFile<CR>')
vim.keymap.set('n', '<leader>a', ':TestSuite<CR>')

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
