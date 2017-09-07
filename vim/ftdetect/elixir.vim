function! s:loadElixirProjections()
  let l:json = readfile(expand("~/.vim/projections/elixir.json"))
  call projectionist#append(getcwd(), projectionist#json_parse(l:json))
endfunction

autocmd User ProjectionistDetect :call s:loadElixirProjections()
