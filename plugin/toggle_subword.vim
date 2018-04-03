let s:subwordexp = '\u\l\@=\|\u\l\@=\|\A\@<=\a\|\a\A\@=\|\D\@<=\d\|\d\D\@=\|\s\@<=\S\|\S\s\@=\|\S$\|^.\|.$'
let s:subwordbegin = '\l\@<=\u\|\(\u\{2}\)\@<=\l\|\A\@<=\a\|\D\@<=\d\|\s\@<=\S\|\<\|^.'
let s:subwordend = '\l\u\@=\|\(\u\@<=\u\l\@=\)\|\a\A\@=\|\d\D\@=\|\S\s\@=\|\S$\|\>\|.$'
let s:WORDboundary = '\_s\@<=\S\|\S\_s\@=\|^\S'
let s:wordboundary = '\W\@<=\w\|\w\W\@=\|^\w\|\w$\|\<\|\>'
let s:whitespaceboundary = '\S\@<=\s\|\s\S\@=\|^\s\|\s$'
let s:punct = '[!<>+\-=&|]\{3,}\|[!<>+\-=&|]\{2}\|()\|\[\]\|{}\|.'

fu! VisualSubwordExpand() range
  noau
  let pq = @/
  let ppos = getcurpos()
  let lppos = getpos("'<")
  let rppos = getpos("'>")
  
  if search("\\%'>\\%#\\_.\\{2}",'neW')
    call search(s:subwordend,'')
    call setpos("'>", getcurpos())
    call setpos("'<", lppos)
    let @/ = pq
    exe 'normal! gv'
    return
  endif

  if search("\\_.\\%#\\%'<",'nbcW')
    call search(s:subwordbegin,'b')
    call setpos("'<", getcurpos())
    call setpos("'>", rppos)
    let @/ = pq
    exe 'normal! gvo'
    return
  endif
  
  let @/ = pq
  normal! gv
  return
endf

fu! InnerSubword()
  noau
  if getline('.')[col('.') - 1] =~ '\s'
    normal! w
  endif
  if (getline('.')[col('.') - 1:col('.')] =~ 
        \'\([[:punct:][:space:]]\+$\)\|\(\(\_s\|\<\)\S\(\_s\|\>\)\)')
    normal v
  endif
  if (getline('.')[col('.') - 1:col('.')] =~ '[[:punct:]]')
    call search(s:punct, 'cW', line('.'))
    call setpos("'>", getcurpos())
    call search(s:punct, 'cWe', line('.'))
    call setpos("'<", getcurpos())
  else 
    call search(g:subwordend, 'cW', line('.'))
    call setpos("'>", getcurpos())
    call search(g:subwordstart, 'bcW', line('.'))
    call setpos("'<", getcurpos())
  endif

  if mode() =~ '[vns]'
    normal! v`>o`<
  else
    normal! `>v`<
  endif
endf
      
fun! Subword(direction, boundary,...)
    if (a:boundary == 1)
        let e = s:subwordbegin
    elseif (a:boundary == -1)
        let e = s:subwordend
    else " kitchen sink
        let e = s:subwordbegin .'\|'. s:subwordend .'\|'.s:wordboundary.'\|'.s:WORDboundary.'\|'.s:whitespaceboundary
    endif
    let direction = (a:direction == -1) ? 'b' :
                \( (a:direction == 1) ? '' : (a:direction))
    let ret = search(e, direction. 'W')
    nohls
    return ret
endfun

command! SubwordBeginLeft call Subword('b', 1)
command! SubwordEndLeft call Subword('b', -1)
command! SubwordBeginRight call Subword('', 1)
command! SubwordEndRight call Subword('', -1)
command! SubwordBoundaryLeft call Subword('b', 0)
command! SubwordBoundaryRight call Subword('', 0)

map <Plug>SubwordBeginLeft :<C-u>SubwordBeginLeft<CR>
map <Plug>SubwordBeginRight :<C-u>SubwordBeginRight<CR>
map <Plug>SubwordEndLeft :<C-u>SubwordBeginLeft<CR>
map <Plug>SubwordEndRight :<C-u>SubwordEndRight<CR>
map <Plug>SubwordBoundaryLeft :<C-u>SubwordBoundaryLeft<CR>
map <Plug>SubwordBoundaryRight :<C-u>SubwordBoundaryRight<CR>
vmap <Plug>VisualSubwordLeft <Esc>:<C-u>SubwordBeginLeft<CR>mzgv`z
vmap <Plug>VisualSubwordRight <Esc>:<C-u>SubwordEndRight<CR>mzgv`z
vmap <Plug>VisualSubwordExpand <Esc>:call VisualSubwordExpand()<CR>
map <Plug>InnerSubword :<C-u>call InnerSubword()<CR>
omap <Plug>InnerSubword :call InnerSubword()<CR>
vmap <Plug>VisualSubwordExpand :call VisualSubwordExpand()<CR>
