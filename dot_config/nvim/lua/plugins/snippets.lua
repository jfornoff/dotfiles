return {
  'SirVer/ultisnips',
  dependencies = {
    'honza/vim-snippets',
  },
  config = function()
    vim.g["UltiSnipsSnippetDirectories"] = {
      vim.fn.stdpath('config') .. '/snippets/',
    }
    vim.keymap.set('n', '<leader>se', ':UltiSnipsEdit')
  end
}
