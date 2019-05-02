function!  myspacevim#before() abort
  auto FileType markdown,txt
    \ inoremap <expr> < "<><left>" |
    \ inoremap <expr> * "**<left>"
endfunction
