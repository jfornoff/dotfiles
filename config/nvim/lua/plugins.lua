-- Bootstrap lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Syntax highlighting.
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  -- Fuzzy search for ~everything.
  'junegunn/fzf',
  'junegunn/fzf.vim',
  -- Snippets
  'SirVer/ultisnips',
  'honza/vim-snippets',
  -- Language Server
  'neovim/nvim-lspconfig',
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
  -- Color scheme
  'altercation/vim-colors-solarized',
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
  -- Language support
  {'rust-lang/rust.vim', ft = 'rust'},
  {'hashivim/vim-terraform', ft = 'terraform'}
})
