-- Closing windows quickly
vim.keymap.set('n', '<leader>c', ':ccl<CR>')

-- Remove search highlighting
vim.keymap.set('n', '<C-l>', ':nohlsearch<CR>')

-- Show diagnostics for current position
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
