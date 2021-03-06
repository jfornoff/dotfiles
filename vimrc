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
Plug 'dense-analysis/ale'
Plug 'tpope/vim-projectionist'
Plug 'raimondi/delimitmate'
Plug 'parkr/vim-jekyll'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'hashivim/vim-terraform', { 'for': 'terraform'}
Plug 'juliosueiras/vim-terraform-completion', { 'for': 'terraform'}
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

syntax on
filetype plugin indent on
set autoindent
set fileformat=unix
set ts=2                          " set indent to 2 spaces
set shiftwidth=2
set number
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

" Fold settings {{{
set foldenable
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
nnoremap \ :Rg<SPACE>

" FZF
let g:fzf_tags_command = 'ctags -R'
map <leader>l :call LanguageClient_contextMenu()<cr>
nmap <leader>f :GitFiles<cr>
nmap <leader>F :Files<cr>
nnoremap <leader>h :Buffers<cr>

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
let test#strategy = "neovim"

" Exit terminal insert mode
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>

let test#ruby#rspec#options = '--format progress'
let test#elixir#exunit#executable = 'mix test.unit'
" }}}

" CTags {{{
map <leader>ct :Dispatch! ctags
" }}}

" Quick Server on port 8000 {{{
map <leader>sv :Dispatch python -m http.server
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

nnoremap <silent> K :ALEHover<cr>
nnoremap gf :call LanguageClient#textDocument_definition()<cr>
nnoremap <leader>r :call LanguageClient#textDocument_references()<cr>
nnoremap <leader>rn :call LanguageClient#textDocument_rename()<cr>

function! OpenCallersInQuickfix(query)
  pyfile ~/.vim/custom_functions/mix-xref-callers.py
endfunction

command! -nargs=1 -complete=customlist,elixircomplete#ex_doc_complete Callers
      \ :call OpenCallersInQuickfix(<f-args>)
" }}}

" LaTeX {{{
let g:tex_flavor='latex'
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"
au FileType tex nnoremap <leader>m :Make!<cr>
" }}}

" Terraform {{{
let g:terraform_fmt_on_save=1
let g:terraform_align=1
let g:terraform_registry_module_completion = 1
" }}}

" Snippets {{{
let g:UltiSnipsSnippetsDir="~/.vim/snippets"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger = "<s-tab>"
" }}}

" Completion {{{
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.terraform = '[^ *\t"{=$]\w*'
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('async_timeout', 10)
call deoplete#initialize()

" Tab complete
function! DoTab()
  if pumvisible()
    return "\<C-n>"
  endif

  return "\<TAB>"
endfunction

inoremap <expr> <TAB> DoTab()
" }}}

" Language Server {{{
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)

    " refer to doc to add more commands
  endfunction


augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  augroup END
"}}}

" ALE {{{
let g:ale_fix_on_save = 1

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'elixir': ['mix_format'],
\   'elm': ['elm-format'],
\   'go': ['gofmt', 'goimports'],
\   'hcl': ['terraform'],
\   'json': ['jq'],
\   'python': ['black'],
\   'ruby': ['rufo', 'standardrb'],
\   'rust': ['rustfmt'],
\   'scala': ['scalafmt'],
\   'sh': ['shfmt'],
\   'terraform': ['terraform'],
\   'javascript': ['prettier'],
\}
"}}}

" vim:foldmethod=marker:foldlevel=0
