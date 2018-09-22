let s:togglewords_shell = [
      \['if', 'elif', 'else', 'fi'],
      \['case', 'esac'],
      \['for', 'done'],
      \['while', 'done'],
      \]

if !(exists('g:toggledict'))
  let g:toggledict = copy(g:toggledict)
endif
  call AddListBuf(s:togglewords_shell)
call extend(g:toggledict, g:toggledict, "keep")

