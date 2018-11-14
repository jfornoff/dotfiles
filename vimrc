" General {{{
set encoding=utf-8
set nocompatible                  " don't need to be compatible with old vim
filetype off

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'ElmCast/elm-vim', { 'for': 'elm' }
Plug 'mattn/emmet-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'jfornoff/vim-rails'
Plug 'janko-m/vim-test'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'w0rp/ale'
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-projectionist'
Plug 'raimondi/delimitmate'
Plug 'parkr/vim-jekyll'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

call plug#end()

syntax on                         " show syntax highlighting
filetype plugin indent on
set autoindent                    " set auto indent
set fileformat=unix
set ts=2                          " set indent to 2 spaces
set shiftwidth=2
set number                        " Line numbers!
set expandtab                     " use spaces, not tab characters
set showmatch                     " show bracket matches
set ignorecase                    " ignore case in search
set hlsearch                      " highlight all search matches
set smartcase                     " pay attention to case when caps are used
set incsearch                     " show search results as I type
set ttimeoutlen=100               " decrease timeout for faster insert with 'O'
set vb                            " enable visual bell (disable audio bell)
set ruler                         " show row and column in footer
set scrolloff=2                   " minimum lines above/below cursor
set laststatus=2                  " always show status bar
set list listchars=tab:»·,trail:· " show extra space characters
set clipboard=unnamed             " use the system clipboard
set wildmenu                      " enable bash style tab completion
set wildmode=list:longest,full
set cursorline                    " Where the hell is my cursor o_o
set relativenumber                " Motions are much easier with relnum
set modelines=1                   " Allow settings from vim comments in files
runtime macros/matchit.vim        " use % to jump between start/end of methods

" }}}

" Bug workarounds {{{
" https://github.com/vim/vim/issues/3117
if has('python3')
    silent! python3 1
endif
"}}}

" Fold settings {{{
set foldenable                    " enable folds
set foldmethod=indent
set foldlevelstart=1
" }}}

" Appearance {{{
" set dark background and color scheme
set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" ruler at 80 characters
if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=8
endif

" highlight trailing spaces in annoying red
highlight ExtraWhitespace ctermbg=1 guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Airline
let g:airline_theme='simple'
let g:airline#extensions#ale#enabled=1
" }}}

" Leader commands {{{

" set leader key to comma
let mapleader = ","

" map git commands
map <leader>b :Gblame<cr>

" Reindent whole file
map <leader>i gg=G

" rename current file, via Gary Bernhardt
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

" Close quickfix window
map <leader>c :ccl<cr>
" }}}

" Navigation {{{
if executable('rg')
  set grepprg=rg\ --color=never\ --vimgrep
elseif executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" FZF
let g:fzf_tags_command = 'ctags -R'
map <leader>l :call LanguageClient_contextMenu()<cr>
nmap <leader>f :GitFiles<cr>
nnoremap <leader>h :Buffers<cr>
nnoremap <leader>g :Tags<cr>

" clear the command line and search highlighting
noremap <C-l> :nohlsearch<CR>

" }}}

" Keybindings {{{
" unmap F1 help
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

" map . in visual mode
vnoremap . :norm.<cr>
" }}}

" Vim-Test {{{
function! UmbrellaElixirTestTransform(cmd) abort
  if a:cmd !~ 'apps/'
    return a:cmd
  endif

  let testCommand = join(split(a:cmd)[0:-2])
  let umbrellaTestFilePath = split(a:cmd)[-1]
  let pathFragments = split(umbrellaTestFilePath, "/")
  let appName = pathFragments[1]
  let localTestPath = join(pathFragments[2:], "/")
  return join(["mix cmd --app ", appName, testCommand, localTestPath])
endfunction

let g:test#custom_transformations = {'elixir': function('UmbrellaElixirTestTransform')}
let g:test#transformation = 'elixir'
let test#strategy = "dispatch"
nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>

let test#ruby#rspec#options = '--format progress'
" }}}

" CTags {{{
map <leader>ct :Dispatch! ctags
" }}}

" Quick Server {{{
map <leader>sv :Dispatch python -m SimpleHTTPServer 8000
"}}}

" Elm {{{
let g:elm_format_autosave = 1
let g:elm_setup_keybindings = 0

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:elm_syntastic_show_warnings = 1
let g:elm_detailed_complete = 1

au FileType elm nnoremap <leader>m :ElmMake<cr>
au FileType elm nnoremap <leader>d :ElmShowDocs<cr>
au FileType elm nnoremap <leader>e :ElmErrorDetail<cr>
" }}}

" Elixir {{{
let g:alchemist#extended_autocomplete = 1
let g:alchemist_tag_map = '<C-d>'

au FileType elixir nnoremap gf :call LanguageClient#textDocument_definition()<cr>

function! ExGoToDef()
  execute 'ExDef' expand('<cWORD>')
endfunction

function! OpenCallersInQuickfix(query)
  pyfile ~/.vim/custom_functions/mix-xref-callers.py
endfunction

command! -nargs=1 -complete=customlist,elixircomplete#ex_doc_complete Callers
      \ :call OpenCallersInQuickfix(<f-args>)
" }}}

" Rust {{{
let g:racer_cmd = "/Users/jfornoff/.cargo/bin/racer"
let g:racer_experimental_completer = 1
" }}}

" LaTeX {{{
let g:tex_flavor='latex'
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"
au FileType tex nnoremap <leader>m :Make!<cr>
" }}}

" Snippets {{{
let g:UltiSnipsSnippetsDir="~/.vim/snippets"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger = "<s-tab>"
" }}}

" Completion {{{
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('async_timeout', 10)

" Tab complete
function! DoTab()
  if pumvisible()
    return "\<C-n>"
  endif

  return "\<TAB>"
endfunction

inoremap <expr> <TAB> DoTab()
" }}}

let g:LanguageClient_serverCommands = {
      \ 'elixir': ['~/bin/elixirls']
      \}
let g:LanguageClient_diagnosticsList = "Location"

let g:neoformat_elixir_elixirfmt = {
  \ 'exe': 'mix',
  \ 'args': ['format', '-'],
  \ 'stdin': 1
  \ }

let g:neoformat_enabled_elixir = ['elixirfmt']

let g:neoformat_markdown_remark = {
  \ 'exe': 'remark',
  \ 'args': ['--no-color', '--silent', '--use', 'remark-frontmatter'],
  \ 'stdin': 1
  \ }

let g:neoformat_enabled_markdown = []

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" vim:foldmethod=marker:foldlevel=0
