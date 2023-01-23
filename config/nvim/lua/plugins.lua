-- Install packer if necessary.
require('packer_bootstrap')

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Syntax highlighting.
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  -- Fuzzy search for ~everything.
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  -- Snippets
  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'
  -- Language Server
  use 'neovim/nvim-lspconfig'
  -- Code completion
  ---- via LSP
  use 'hrsh7th/cmp-nvim-lsp'
  ---- from local buffer words
  use 'hrsh7th/cmp-buffer'
  ---- for file paths
  use 'hrsh7th/cmp-path'
  ---- for command line
  use 'hrsh7th/cmp-cmdline'
  ---- for available snippets
  use 'quangnguyen30192/cmp-nvim-ultisnips'
  use 'hrsh7th/nvim-cmp'
  -- Color scheme
  use 'altercation/vim-colors-solarized'
  -- Running tests async with hotkeys.
  use 'vim-test/vim-test'
  -- Jumping between related files.
  use 'tpope/vim-projectionist'
  -- Surrounding text objects with (usually, but not just) parentheses.
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  })
  -- Auto-close parentheses.
  use 'jiangmiao/auto-pairs'
  -- Language support
  use {'rust-lang/rust.vim', ft = 'rust'}
  use {'hashivim/vim-terraform', ft = 'terraform'}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
