function! s:loadElixirProjections()
  let l:json = readfile(expand("~/.config/nvim/projections/elixir.json"))
  call projectionist#append(getcwd(), projectionist#json_parse(l:json))
endfunction

autocmd User ProjectionistDetect call s:loadElixirProjections()

function! s:umbrellaToLib(input, o) abort
  return substitute(a:input, 'spec', 'lib', '')
endfunction

function! s:umbrellaToSpec(input, o) abort
  return substitute(a:input, 'lib', 'spec', '')
endfunction

function! s:addProjectionistTransformations()
  let g:projectionist_transformations.umbrellaToLib = function('s:umbrellaToLib')
  let g:projectionist_transformations.umbrellaToSpec = function('s:umbrellaToSpec')
endfunction

autocmd User ProjectionistActivate call s:addProjectionistTransformations()

let b:ale_linters = ['elixir-ls']
