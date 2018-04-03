let g:toggleopts = {'overwrite': 0, 'ignorecase': 1}
let g:toggledict = {}
let s:path = resolve(expand('<sfile>:p'))
exe 'so '.substitute(s:path, '\.vim$', '_words.vim', '')

fu! InitToggleDict()
  for i in g:togglewords
    for j in range(0,len(i)-1)
      let g:toggledict[i[j-1]] = i[j]
    endfor
  endfor
endf
call InitToggleDict()

fu! s:ToggleExist(s)
  return (a:s =~ '\S') && (index(values(g:toggledict), a:s) != -1)
endf

fu! InnerSubword()
  if getline('.')[col('.') - 1] =~ '\s'
    normal! w
  endif
  if (getline('.')[col('.') - 1:col('.')] =~ '\([[:punct:][:space:]]\+$\)\|\(\(\_s\|\<\)\S\(\_s\|\>\)\)')
    normal v
  endif
  call search(g:subwordend, 'cW', line('.'))
  call setpos("'>", getcurpos())
  call search(g:subwordstart, 'bcW', line('.'))
  call setpos("'<", getcurpos())
  if mode() =~ '[vns]'
    normal! v`>o`<
  else
    normal! `>v`<
  endif
endf

vnoremap <silent> <C-s> :<C-u>call InnerSubword()<CR>
onoremap <silent> <C-s> :call InnerSubword()<CR>
nnoremap <silent> d<C-s> d:call InnerSubword()<CR>
nnoremap <silent> y<C-s> y:call InnerSubword()<CR>
nnoremap <silent> c<C-s> c:call InnerSubword()<CR>

fu! s:DetectCase(...)
  if a:1 =~? '^\l\+$'
    return 'lower'
  elseif a:1 =~? '^\u\+$'
    return 'upper'
  elseif a:1 =~? '\u\l\+'
    return 'capitalized'
  else " can't detect capitalization
    return 'lower'
  endif
endf
" command! -register DetectCase call s:DetectCase()

fu! s:StripWhitespace(s)
  return substitute(a:s,'^\s*\(\S\+\)\s*$','\1','')
endf

" strip trailing/preceding whitespace,
" remove delete / backspace characters
" portability questionable
fu! s:InsertCleanUp(s)
  let s = s:StripWhitespace(a:s)

  for i in range(0,50)
    if s =~ "\<BS>\\|\<Del>\\|\<C-w>"
      let s = substitute(s,'\([^bD]kb\)\|\(\kD[^bD]\)','','g')
      let s = substitute(s,'\W\@<=\w*','','g')
      let s = substitute(s,'\(\S\@<=\s*\)','','g')
      let s = substitute(s,'\(\(\S\|\w\)\@<=\W\{-1,}\)','','g')
    else
      let s = substitute(s,'\(.kb\)\|\(\kD.\)','','g')
      break
    endif
  endfor
  let s = substitute(s, '\u\+', '\L&', 'g')
  return s
endf

fu! GetLastChange()
  let lines = getline("'[", "']")
  let lines[-1] = lines[-1][0:col("']") - 2]
  let lines[0] = lines[0][(col("'[") - 1):-1]
  return join(lines, '')
endf

fu! AddToggle(...)
  if (a:0 >= 2)
    let a = s:StripWhitespace(a:1)
    let b = s:StripWhitespace(a:2)
  elseif v:operator =~? 'c'
    let a = s:StripWhitespace(@-)
    let b = s:InsertCleanUp(GetLastChange())
  else
    return
  endif
    
  " No multi-word toggles
  if a =~ '\s'
    return
  end
  " don't overwrite
  if !g:toggleopts['overwrite'] && s:ToggleExist(a) && s:ToggleExist(b)
    return
  endif

  if g:toggleopts['overwrite']
    let g:toggledict[a] = b
    let g:toggledict[b] = a
    return
  endif

  "  add to toggle ring
  if s:ToggleExist(a)
    let g:toggledict[b] = g:toggledict[a]
    let g:toggledict[a] = b
    return
  endif
  if s:ToggleExist(b)
    let g:toggledict[a] = g:toggledict[b]
    let g:toggledict[b] = a
    return
  endif
  " Make binary toggle
  let g:toggledict[a] = b
  let g:toggledict[b] = a
endf
au InsertLeave * call AddToggle()

fu! ToggleSelection()
  let lin = getline('.')
  let ccol = col('.') - 1
  let sel = lin[col("'<") - 1: col("'>") - 1]
  normal! "_ym`

  if sel =~ '^\d\+$'
    exe "normal! \<C-A>`["
    return
  endif

  " No multi-word, no blanks
  if sel !~ '\S'
    return
  endif

  let a:case = (s:DetectCase(sel))

  if g:toggleopts['ignorecase']
    let sel = substitute(sel, '\u', '\L&', 'g')
  endif

  " No toggle set for sel
  if (index(values(g:toggledict), sel) == -1)
    return
  else
    let word = g:toggledict[sel]
    if a:case !~? 'lower'
      let word = substitute(word, '\l\+', ((a:case =~? 'capitalized') ? '\u&' : '\U&'), '')
    endif

    let prevcol = col('.')
    exe 'silent! :s;\(\%#\V' . sel . '\);' . word . ';'
    exe 'normal! '.prevcol.'|'
  endif
endf
command! -register ToggleSelection call ToggleSelection()

fu! ToggleWord()
  call InnerSubword()
  call ToggleSelection()
endf
command! -register ToggleWord call ToggleWord()

nnoremap <silent> <M-t> :ToggleWord<CR>
nnoremap <silent> <leader><M-t> :call AddToggle(@0, @-)<CR>
vnoremap <silent> <M-t> :<C-u>ToggleSelection<CR>
" vnoremap <silent> p p:call AddToggle(@0, @-)<CR>
