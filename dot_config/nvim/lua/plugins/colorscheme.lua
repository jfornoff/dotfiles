return {
  'altercation/vim-colors-solarized',
  config = function()
    vim.g.solarized_termcolors = 256
    vim.opt.background = "dark"
    vim.cmd 'colorscheme solarized'
  end
}
