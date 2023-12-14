-- Running tests async with hotkeys.
return {
  'vim-test/vim-test',
  config = function()
    vim.keymap.set('n', '<leader>T', ':TestNearest<CR>')
    vim.keymap.set('n', '<leader>t', ':TestFile<CR>')
    vim.keymap.set('n', '<leader>a', ':TestSuite<CR>')
  end
}

