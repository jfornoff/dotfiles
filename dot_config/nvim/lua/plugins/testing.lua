-- Running tests async with hotkeys.
return {
  'vim-test/vim-test',
  config = function()
    vim.g['test#strategy'] = 'neovim'
    -- Exit terminal insert mode easily
    vim.keymap.set('t', '<C-o>', '<C-\\><C-n>')
    -- Testing keymaps
    vim.keymap.set('n', '<leader>T', ':TestNearest<CR>')
    vim.keymap.set('n', '<leader>t', ':TestFile<CR>')
    vim.keymap.set('n', '<leader>a', ':TestSuite<CR>')
  end
}
