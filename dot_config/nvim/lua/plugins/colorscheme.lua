return {
  -- Active: solarized.nvim — treesitter and LSP semantic token aware,
  -- unlike the original altercation/vim-colors-solarized (2011).
  {
    'maxmx03/solarized.nvim',
    priority = 1000,
    config = function()
      require('solarized').setup()
      vim.opt.background = 'dark'
      vim.cmd 'colorscheme solarized'
    end,
  },

  -- Alternatives — to try one: uncomment its block, comment out the active block above.
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd 'colorscheme catppuccin-mocha'
  --   end,
  -- },
  -- {
  --   'folke/tokyonight.nvim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd 'colorscheme tokyonight-night'
  --   end,
  -- },
}
