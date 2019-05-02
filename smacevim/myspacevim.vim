function!  myspacevim#before() abort
  auto FileType markdown,txt        let b:delimitMate_matchpairs = "(:),[:],{:},<:>,*:*,《:》"
endfunction
