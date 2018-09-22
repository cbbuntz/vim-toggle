let s:togglewords_vim = [
      \['fu', 'endf'],
      \['fun', 'endfun'],
      \['function', 'endfunction'],
      \['if', 'elseif', 'else', 'endif'],
      \['for', 'endfor'],
      \['while', 'endwhile'],
      \['try', 'catch', 'throw', 'endtry'],
      \['function', 'endfunction'],
      \['fun', 'endfun'],
      \['noremap', 'nnoremap', 'vnoremap', 'xnoremap', 'inoremap', 'cnoremap'],
      \['map', 'nmap', 'vmap', 'xmap', 'imap', 'cmap'],
      \['silent', 'buffer', 'nowait'],
      \]

if !(exists('g:toggledict'))
  let g:toggledict = copy(g:toggledict)
endif
  call AddListBuf(s:togglewords_vim)
call extend(g:toggledict, g:toggledict, "keep")

