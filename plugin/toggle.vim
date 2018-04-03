let g:togglewords = [
      \['zero',  'one',  'two',  'three',  'four',  'five',  'six',  'seven',  'eight',  'nine',  'ten',
      \'eleven',  'twelve',  'thirteen', 'fourteen',  'fifteen',  'sixteen',  'seventeen',  'eighteen',  'nineteen'],
      \['import', 'export'],
      \['join', 'split'],
      \[ 'enable', 'disable' ],
      \[ 'enabled', 'disabled' ],
      \[ 'start', 'end', 'begin' ],
      \[ 'on', 'off' ],
      \[ 'true', 'false' ],
      \[ 'yes', 'no' ],
      \[ '(', ')' ],
      \[ '[', ']' ],
      \[ '{', '}' ],
      \[ '*', '/' ],
      \[ '&', '|' ],
      \[ '&&', '||' ],
      \[ '+', '-' ],
      \[ '/', '*' ],
      \[ '++', '--' ],
      \[ '+=', '-=' ],
      \[ '*=', '/=' ],
      \[ '<', '>' ],
      \[ '<<', '>>' ],
      \[ '<=', '>=' ],
      \[ '==', '!=' ],
      \[ '===', '!==' ],
      \[ 'get', 'set' ],
      \['short', 'long'],
      \[ 'absolute', 'relative' ],
      \[ 'high', 'low' ],
      \[ 'horizontal', 'vertical' ],
      \[ 'in', 'out' ],
      \[ 'inner', 'outer' ],
      \[ 'left', 'right' ],
      \[ 'top', 'bottom' ],
      \[ 'up', 'down' ],
      \[ 'forward', 'back' ],
      \[ 'black', 'gray', 'white' ],
      \[ 'dark', 'light' ],
      \[ 'join', 'split' ],
      \[ 'pop', 'push' ],
      \[ 'shift', 'unshift' ],
      \[ 'atan', 'tan' ],
      \[ 'ceil', 'floor' ],
      \[ 'cos', 'sin' ],
      \[ 'min', 'max' ],
      \[ 'minor', 'major' ],
      \[ 'copy', 'cut', 'paste' ],
      \[ 'keydown', 'keyup' ],
      \[ 'mousedown', 'mouseup' ],
      \[ 'mouseenter', 'mouseleave' ],
      \[ 'head', 'body' ],
      \[ 'header', 'footer' ],
      \[ 'ol', 'ul' ],
      \[ 'tr', 'td' ],
      \[ 'activate', 'deactivate' ],
      \[ 'add', 'remove' ],
      \[ 'background', 'foreground' ],
      \[ 'available', 'unavailable' ],
      \[ 'before', 'after' ],
      \[ 'client', 'server' ],
      \[ 'connect', 'disconnect' ],
      \[ 'connected', 'disconnected' ],
      \[ 'first', 'last' ],
      \[ 'from', 'to' ],
      \[ 'input', 'output' ],
      \[ 'install', 'uninstall' ],
      \[ 'key', 'value' ],
      \[ 'online', 'offline' ],
      \[ 'open', 'close' ],
      \[ 'parent', 'child' ],
      \[ 'positive', 'negative' ],
      \[ 'prefix', 'suffix' ],
      \[ 'previous', 'next' ],
      \[ 'public', 'private' ],
      \[ 'req', 'res' ],
      \['request', 'response'],
      \[ 'row', 'column' ],
      \[ 'show', 'hide' ],
      \[ 'source', 'destination' ],
      \[ 'start', 'stop' ],
      \[ 'valid', 'invalid' ],
      \[ 'visible', 'hidden' ],
      \[ 'valid', 'invalid'], 
      \[ 'width', 'height' ],
      \[ 'x', 'y' ],
      \[ 'fun', 'endfun' ],
      \[ 'function', 'endfunction' ],
      \[ 'fun', 'endfun' ],
      \[ 'if', 'endif', 'fi' ],
      \[ 'for', 'endfor' ],
      \[ 'lower', 'upper' ],
      \[ 'lowercase', 'uppercase' ],
      \[ 'try', 'catch', 'throw' ],
      \[ 'and', 'or', 'xor', 'not', 'nand' ],
      \[ 'win', 'lose'],
      \[ 'malloc', 'calloc', 'free'],
      \['gray', 'maroon', 'red', 'purple', 'fuchsia', 'green', 'yellow', 'blue', 'aqua'],
      \['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'] ]

let g:toggledict = {}
let g:toggleopts = {'overwrite': 0, 'ignorecase': 0}

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

fu! VimToggleWords()
  let g:togglewords += [
        \['fun', 'endf', 'endfun'],
        \['function', 'endfunction'],
        \['if', 'endif'],
        \['for', 'endfor'],
        \['while', 'endwhile'],
        \[ 'try', 'catch', 'throw', 'endtry'],
        \]
endf

fu! InnerSubword()
  if (getline('.')[col('.') - 1:col('.')] =~ '\([[:punct:][:space:]]\+$\)\|\(\s\S\s\)')
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
  let col = col('.') - 1
  normal! "xym`

  if @x =~? '^\d\+$'
    exe "normal! \<C-A>"
    return
  endif

  if @x =~ '^\s\+$'
    return
  endif

  let a:case = (DetectCase(@x))

  if g:toggleopts['ignorecase']
    let sel = @x
  else 
    let sel = substitute(@x, '\u', '\L&', 'g')
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

