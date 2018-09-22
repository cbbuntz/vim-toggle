let s:togglewords_ruby = [
      \['if', 'elsif', 'else'],
      \['def', 'end'],
      \]
      " \['for', 'end'],
      " \['while', 'end'],
      " \['begin', 'rescue', 'ensure', 'end'],

if !(exists('g:toggledict'))
  let g:toggledict = copy(g:toggledict)
endif

call AddListBuf(s:togglewords_ruby)
call extend(g:toggledict, g:toggledict, "keep")

