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

fu! ToggleExist(s)
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

fu! DetectCase(...)
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
command! -register DetectCase call DetectCase()

" strip trailing/preceding whitespace,
" remove delete / backspace characters
" portability questionable
fu! InsertCleanUp(s)
  let s = substitute(a:s,'^\s*\(\S\+\)\s*$','\1','')

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

fu! AddToggle()
  if v:operator =~? 'c'
    let a = InsertCleanUp(@-)
    let b = InsertCleanUp(@.)
    " No multi-word toggles
    if a =~ '\s'
      return
    end
    " don't overwrite
    if !g:toggleopts['overwrite'] && ToggleExist(a) && ToggleExist(b)
      return
    endif
    
    if g:toggleopts['overwrite']
      let g:toggledict[a] = b
      let g:toggledict[b] = a
      return
    endif
        
   "  add to toggle ring
    if ToggleExist(a)
      let g:toggledict[b] = g:toggledict[a]
      let g:toggledict[a] = b
      return
    endif
    if ToggleExist(b)
      let g:toggledict[a] = g:toggledict[b]
      let g:toggledict[b] = a
      return
    endif
    " Make binary toggle
    let g:toggledict[a] = b
    let g:toggledict[b] = a
  endif
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

  if sel =~ '^\s\+$'
    return
  endif

  let a:case = (DetectCase(sel))

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
vnoremap <silent> <M-t> :<C-u>ToggleSelection<CR>
