let g:toggleopts = {'overwrite': 0, 'ignorecase': 1}
let g:toggledict = {}
let s:path = resolve(expand('<sfile>:p'))
exe 'so '.substitute(s:path, '\.vim$', '_words.vim', '')
exe 'so '.substitute(s:path, '\.vim$', '_subword.vim', '')

fu! InitToggleDict()
  for i in g:togglewords
    for j in range(0,len(i)-1)
      let g:toggledict[i[j-1]] = i[j]
    endfor
  endfor
  for i in g:togglepunct
    for j in range(0,len(i)-1)
      let g:toggledict[i[j-1]] = i[j]
    endfor
  endfor
endf
call InitToggleDict()

fu! s:ToggleExist(s)
  return (a:s =~ '\S') && (index(values(g:toggledict), a:s) != -1)
endf

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

" strip trailing/preceding whitespace
fu! s:StripWhitespace(s)
  return substitute(a:s,'^\s*\(\S\+\)\s*$','\1','')
endf

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

fu! ToggleFindBrute(key,ar)
  for i in a:ar
    for j in range(0,len(i)-1)
      if a:key =~ '\V'.i[j]
        return substitute(i[(j+1) % len(i)], '&', '\\\&', 'g')
      end
    endfor
  endfor
  return a:key
endf

fu! ToggleSelection()
  let lin = getline('.')
  let ccol = col('.') - 1
  let sel = lin[col("'<") - 1: col("'>") - 1]
  normal! "_ym`

  if sel =~ '^\d\+$'
    exe "normal! \<C-A>`["
    return
  endif
  
  " if sel =~ '[[:punct:]]'
  "   let sub = ToggleFindBrute(sel, g:togglepunct)
  "   exe 's:\V'. sel .':'. sub .':'
  "   exe 'normal! '. (ccol+1) .'|'
  "   return
  " endif

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
    exe 'silent! :s;\(\%#\V' . sel . '\);' . substitute(word, '&', '\\\&', 'g') . ';'
    exe 'normal! '.prevcol.'|'
  endif
endf
command! -register ToggleSelection call ToggleSelection()

fu! ToggleWord()
  call InnerSubword()
  call ToggleSelection()
endf
command! -register ToggleWord call ToggleWord()

nmap <Plug>ToggleWord :call ToggleWord()<CR>
vmap <Plug>ToggleWord :<C-u>ToggleSelection()<CR>

nnoremap <silent> <M-t> :ToggleWord<CR>
nnoremap <silent> <leader><M-t> :call AddToggle(@0, @-)<CR>
vnoremap <silent> <M-t> :<C-u>ToggleSelection<CR>
" vnoremap <silent> p p:call AddToggle(@0, @-)<CR>

