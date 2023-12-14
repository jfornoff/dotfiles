return {
  -- Tool dependency management
  'williamboman/mason.nvim',
  -- Syntax highlighting.
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
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
  'jiangmiao/auto-pairs',
}
