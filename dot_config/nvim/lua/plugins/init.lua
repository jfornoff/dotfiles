return {
  -- Tool dependency management
  'williamboman/mason.nvim',
  -- Syntax highlighting.
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  -- Fuzzy search for ~everything.
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  'fhill2/telescope-ultisnips.nvim',
  -- Snippets
  'SirVer/ultisnips',
  'honza/vim-snippets',
  -- Language Server
  'neovim/nvim-lspconfig',
  ----- For Lua
  { "folke/neodev.nvim",               opts = {} },
  ---- Pictograms for the type of completions
  'onsails/lspkind.nvim',
  -- Code completion
  ---- via LSP
  'hrsh7th/cmp-nvim-lsp',
  ---- from local buffer words
  'hrsh7th/cmp-buffer',
  ---- for file paths
  'hrsh7th/cmp-path',
  ---- for command line
  'hrsh7th/cmp-cmdline',
  ---- for available snippets
  'quangnguyen30192/cmp-nvim-ultisnips',
  'hrsh7th/nvim-cmp',
  -- Running tests async with hotkeys.
  'vim-test/vim-test',
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
