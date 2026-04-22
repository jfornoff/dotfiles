return {
  -- Tool dependency management
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  -- Syntax highlighting.
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'lua', 'rust', 'go', 'c', 'java', 'bash', 'yaml', 'vim', 'vimdoc' },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
  -- Jumping between related files.
  'tpope/vim-projectionist',
  -- Surrounding text objects with (usually, but not just) parentheses.
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  -- Auto-close parentheses.
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
}
