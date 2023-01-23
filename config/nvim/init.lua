-- General settings {{{
vim.opt.encoding = 'utf-8'
vim.opt.compatible = false
vim.opt.autoindent = true
vim.opt.fileformat=unix
vim.opt.ts=2 -- indent by 2 spaces
vim.opt.shiftwidth=2
vim.opt.number = true
vim.opt.ttimeoutlen = 100 -- 100ms to type more command characters
vim.opt.expandtab = true -- use spaces, not tab characters
vim.opt.showmatch = true -- show bracket matches
vim.opt.ignorecase = true -- ignore case in search
vim.opt.hlsearch = true -- highlight all search matches
vim.opt.smartcase = true -- pay attention to case when caps are used
vim.opt.incsearch = true -- show search results as I type
vim.opt.vb = true -- enable visual bell (disable audio bell)
vim.opt.scrolloff=2 -- minimum visible lines around cursor when scrolling
vim.opt.list = true -- show tabs / trailing spaces
vim.opt.listchars='tab:»·,trail:·'
vim.opt.cursorline = true -- Where the hell is my cursor o_o
vim.opt.relativenumber = true -- Motions are much easier with relnum
vim.opt.modelines=1 -- Allow settings from vim comments in files
vim.cmd('runtime macros/matchit.vim') -- use % to jump between start/end of methods
-- }}}

-- Fold settings {{{
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- }}}

require('plugins')
require('language_server')
require('appearance')
require('keybindings')
