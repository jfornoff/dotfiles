return {
  'SirVer/ultisnips',
  dependencies = {
    'honza/vim-snippets',
  },
  config = function()
    vim.g["UltiSnipsSnippetDirectories"] = {
      -- From plugins
      "UltiSnips",
      -- Private snippets
      vim.fn.stdpath('config') .. '/snip/',
    }
    vim.keymap.set('n', '<leader>se', ':UltiSnipsEdit')
  end
}
