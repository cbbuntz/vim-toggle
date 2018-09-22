if exists("g:loaded_vim_toggle")
  finish
endif

let g:loaded_vim_toggle = 1

let g:toggleopts = {'overwrite': 0, 'ignorecase': 1}
let g:toggledict = {}
let s:path = resolve(expand('<sfile>:p'))

" **** WORDS ****

let g:togglepunct = [
      \['()', '[]', '{}'],
      \['""', "''", '``'],
      \['(', ')'],
      \['[', ']'],
      \['{', '}'],
      \['&&', '||'],
      \['++', '--'],
      \['<<<', '>>>'],
      \['<<', '>>'],
      \['<=', '>='],
      \['&&=', '||='],
      \['&=', '|='],
      \['+=', '-='],
      \['*=', '/='],
      \['===', '!=='],
      \['==', '!='],
      \['&', '|'],
      \['+', '-'],
      \['*', '/'],
      \['<', '>'],
      \]

let g:togglewords_universal = [
      \['on', 'off'],
      \['true', 'false'],
      \['yes', 'no'],
      \['left', 'right'],
      \['up', 'down'],
      \['min', 'max'],
      \['minimum', 'maximum'],
      \['zero',  'one',  'two',  'three',  'four',  'five',  'six',  'seven',  'eight',  'nine',  'ten',
      \'eleven',  'twelve',  'thirteen', 'fourteen',  'fifteen',  'sixteen',  'seventeen',  'eighteen',  'nineteen'],
      \['january', 'february', 'march', 'april', 'may', 'june', 'july', 'august', 'september', 'october', 'november', 'december'],
      \['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'],
      \['in', 'out'],
      \['lower', 'upper'],
      \['positive', 'negative'],
      \['import', 'export'],
      \['enable', 'disable'],
      \['enabled', 'disabled'],
      \['horizontal', 'vertical'],
      \['start', 'stop'],
      \['first', 'last'],
      \['input', 'output'],
      \['background', 'foreground'],
      \['available', 'unavailable'],
      \['before', 'after'],
      \['client', 'server'],
      \['atan', 'tan'],
      \['ceil', 'floor'],
      \['cos', 'sin'],
      \['minor', 'major'],
      \]

let g:togglewords = [
      \['join', 'split'],
      \['end', 'begin'],
      \['get', 'set'],
      \['short', 'long'],
      \['absolute', 'relative'],
      \['high', 'low'],
      \['inner', 'outer'],
      \['top', 'bottom'],
      \['forward', 'back'],
      \['black', 'gray', 'white'],
      \['dark', 'light'],
      \['join', 'split'],
      \['pop', 'push'],
      \['shift', 'unshift'],
      \['copy', 'cut', 'paste'],
      \['keydown', 'keyup'],
      \['mousedown', 'mouseup'],
      \['mouseenter', 'mouseleave'],
      \['head', 'body'],
      \['header', 'footer'],
      \['ol', 'ul'],
      \['tr', 'td'],
      \['activate', 'deactivate'],
      \['add', 'remove'],
      \['connect', 'disconnect'],
      \['connected', 'disconnected'],
      \['from', 'to'],
      \['install', 'uninstall'],
      \['key', 'value'],
      \['online', 'offline'],
      \['open', 'close'],
      \['parent', 'child'],
      \['prefix', 'suffix'],
      \['previous', 'next'],
      \['pre', 'post'],
      \['public', 'private'],
      \['req', 'res'],
      \['request', 'response'],
      \['row', 'column'],
      \['show', 'hide'],
      \['source', 'destination'],
      \['valid', 'invalid'],
      \['visible', 'hidden'],
      \['valid', 'invalid'],
      \['width', 'height'],
      \['lowercase', 'uppercase'],
      \['try', 'catch', 'throw'],
      \['and', 'or', 'xor', 'not', 'nand'],
      \['win', 'lose'],
      \['malloc', 'calloc', 'free'],
      \['nan', 'inf'],
      \['red', 'orange', 'yellow',  'green', 'cyan', 'blue',  'purple', 'magenta'],
      \]

" **** SUBWORD ****

let g:subwordexp = '\u\l\@=\|\u\l\@=\|\A\@<=\a\|\a\A\@=\|\D\@<=\d\|\d\D\@=\|\s\@<=\S\|\S\s\@=\|\S$\|^.\|.$'
let g:subwordbegin = '\l\@<=\u\|\(\u\{2}\)\@<=\l\|\A\@<=\a\|\D\@<=\d\|\s\@<=\S\|\<\|^.'
let g:subwordstart = '\l\@<=\u\|\(\u\{2}\)\@<=\l\|\A\@<=\a\|\D\@<=\d\|\s\@<=\S\|\<\|^.'
let g:subwordend = '\l\u\@=\|\(\u\@<=\u\l\@=\)\|\a\A\@=\|\d\D\@=\|\S\s\@=\|\S$\|\>\|.$'
let g:WORDboundary = '\_s\@<=\S\|\S\_s\@=\|^\S'
let g:wordboundary = '\W\@<=\w\|\w\W\@=\|^\w\|\w$\|\<\|\>'
let g:whitespaceboundary = '\S\@<=\s\|\s\S\@=\|^\s\|\s$'
let g:punct = '[!<>+\-=&|]\{3,}\|[!<>+\-=&|]\{2}\|()\|\[\]\|{}\|.'

fu! VisualSubwordExpand() range
  noau
  let pq = @/
  let ppos = getcurpos()
  let lppos = getpos("'<")
  let rppos = getpos("'>")

  if search("\\%'>\\%#\\_.\\{2}",'neW')
    call search(g:subwordend,'')
    call setpos("'>", getcurpos())
    call setpos("'<", lppos)
    let @/ = pq
    exe 'normal! gv'
    return
  endif

  if search("\\_.\\%#\\%'<",'nbcW')
    call search(g:subwordbegin,'b')
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
    let e = g:subwordbegin
  elseif (a:boundary == -1)
    let e = g:subwordend
  else " kitchen sink
    let e = g:subwordbegin .'\|'. g:subwordend .'\|'.s:wordboundary.'\|'.s:WORDboundary.'\|'.s:whitespaceboundary
  endif
  let direction = (a:direction == -1) ? 'b' :
        \( (a:direction == 1) ? '' : (a:direction))
  let ret = search(e, direction. 'W')
  nohls
  return ret
endfun

" **** LCS ****

fu! LCS(x, y)
  ruby <<RB
  def lcs(xstr, ystr)
  return "" if xstr.empty? || ystr.empty?
  x, xs, y, ys = xstr[0..0], xstr[1..-1], ystr[0..0], ystr[1..-1]
  if x == y
    x + lcs(xs, ys)
  else
    [lcs(xstr, ys), lcs(xs, ystr)].max_by {|x| x.size}
  end
end

xstr = VIM::evaluate('a:x')
ystr = VIM::evaluate('a:y')
puts lcs(xstr,ystr)
#VIM.command("let ret = '".lcs(xstr,ystr)."'")
RB
" echo ret
endf

fu! KeyMatch(str)
  let keys = keys(g:toggledict)
  call filter(keys, 'len(v:val) > 0')
  return filter(keys, '(a:str =~? v:val) || (a:str =~? v:val)')
endf

fu! s:SortByLenCmp(i1, i2)
  let [l1, l2] = [len(a:i1), len(a:i2)]
  return l1 == l2 ? 0 : l2 > l1 ? 1 : -1
endf

fu! SortByLen(list)
  return sort(a:list, 's:SortByLenCmp')
endf

fu! LCSKeyLine()
  let ln = getline('.')
  let a = Downcase(substitute(ln[:max([0,(col('.')-2)])], '^.*\s', '', ''))
  let b = Downcase(substitute(ln[max([1,(col('.')-1)]):], '\s.*$', '', ''))
  let str = a . b

  if str !~ '\S'
    return [b]
  elseif len(str) == 1
    return [str]
  endif

  let matches = KeyMatch(str)

  if str =~ '\d'
    let matches += [matchstr(str, '\d\+')]
  endif
  if str =~ '\<[a-zA-Z]\>'
    let matches += [matchstr(str, '\<[a-zA-Z]\>')]
  endif
  let matches = SortByLen(uniq(sort(matches)))
  return matches
endf


fu! s:AddList(list)
  for i in a:list
    for j in range(0,len(i)-1)
      let g:toggledict[i[j-1]] = i[j]
    endfor
  endfor
endf

fu! AddListBuf(list)
  for i in a:list
    for j in range(0,len(i)-1)
      let g:toggledict[i[j-1]] = i[j]
    endfor
  endfor
endf

fu! InitToggleDictFiletype()
  if !(exists('g:toggledict'))
    let g:toggledict = copy(g:toggledict)
  endif
  if &filetype =~ 'sh\|bash\|zsh\|profile'
    call AddListBuf(g:togglewords_shell)
  elseif &filetype =~ 'rb'
    call AddListBuf(g:togglewords_ruby)
  elseif &filetype =~ 'vim'
    call AddListBuf(g:togglewords_vim)
  endif
  call extend(g:toggledict, g:toggledict, "keep")
endf

fu! InitToggleDict()
  call s:AddList(g:togglepunct)
  call s:AddList(g:togglewords)
  call s:AddList(g:togglewords_universal)
  call InitToggleDictFiletype()
endf

au VimEnter * call InitToggleDict()

fu! s:ToggleExist(s)
  return (a:s =~ '\S') && (index(values(g:toggledict), Downcase(a:s)) != -1)
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

fu! Downcase(s)
  return substitute(a:s, '.*', '\L&', '')
endf

fu! Upcase(s)
  return substitute(a:s, '.*', '\U&', '')
endf

fu! Captialize(s)
  return substitute(a:s, '\(.\)\(.*\)', '\u\1\L\2', '')
endf

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

fu! ToggleNew(a,b,flag)
  if a:flag == 0
    let g:toggledict[a:a] = a:b
    let g:toggledict[a:b] = a:a
  elseif a:flag == 1
    let g:toggledict[a:b] = g:toggledict[a:a]
    let g:toggledict[a:a] = a:b
  endif
endf

fu! ToggleAdd(...)
  if (a:0 >= 2)
    let a = s:StripWhitespace(a:1)
    let b = s:StripWhitespace(a:2)
  elseif v:operator =~? 'c'
    let a = s:StripWhitespace(@-)
    let b = s:InsertCleanUp(GetLastChange())
  else
    return
  endif

  let a = Downcase(a)
  let b = Downcase(b)

  if a =~ '\s' " No multi-word toggles
    return
  endif

  if !g:toggleopts['overwrite'] && s:ToggleExist(a) && s:ToggleExist(b)
    return
  elseif g:toggleopts['overwrite']
    return ToggleNew(a,b,0)
  elseif s:ToggleExist(a)
    return ToggleNew(a,b,1)
  elseif s:ToggleExist(b)
    return ToggleNew(b,a,1)
  endif
  return ToggleNew(a,b,0)
endf

au InsertLeave * call ToggleAdd()

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

fu! TogglePrevious(w)
  call extend(g:toggledict, g:toggledict, "keep")
  if (index(values(g:toggledict), a:w) == -1)
    return a:w
  endif
  let word = a:w
  while (g:toggledict[word] != a:w)
    let word = g:toggledict[word]
  endwhile
  return word
endf

fu! RotLetter(...)
  let rev = (a:0 && (a:1 != 0))
  noau
  ruby <<RB
  ln = VIM::Buffer.current.line
  l, c = VIM::Window.current.cursor
  if VIM::eval('rev') == 1
    ln[c] = (ln[c].ord-1).chr
    ln[c] = (ln[c].ord+26).chr if ln[c] =~ /[@`]/
  else
    ln[c] = ln[c].succ[0]
  end
  VIM::Buffer.current.line = ln
  VIM::Window.current.cursor = [l,c]
  RB
  if exists("g:loaded_repeat")
    call repeat#set(":call RotLetter()\<CR>")
  endif
endf

fu! GetToggleWord(sel)
  if (index(values(g:toggledict), a:sel) != -1)
    " let word = ((rev) ? (TogglePrevious(a:sel)) : (g:toggledict[a:sel]))
    let word = g:toggledict[a:sel]
  elseif (index(values(g:toggledict), a:sel) != -1)
    " let word = ((rev) ? (TogglePrevious(a:sel)) : (g:toggledict[a:sel]))
    let word = g:toggledict[a:sel]
  else
    return a:sel
  endif

  return word
endf

fu! ToggleSelection(...)
  noau
  let rev = (a:0 && (a:1 == -1))
  let lin = getline('.')
  let ccol = col('.') - 1
  let sel = lin[col("'<") - 1: col("'>") - 1]
  normal! "_ym`

  " No multi-word, no blanks
  if sel !~ '\S'
    return
  endif

  if sel =~ '^\d\+$'
    if rev
      exe "normal! \<C-X>`["
    else
      exe "normal! \<C-A>`["
    endif
    return
  endif

  if sel =~ '\<[a-zA-Z]\>'
    if rev
      return RotLetter(1)
    else
      return RotLetter()
    endif
  endif

  let a:case = (s:DetectCase(sel))

  let oldsel = sel
  if g:toggleopts['ignorecase']
    let sel = substitute(sel, '\u', '\L&', 'g')
  endif

  " No toggle set for sel
  if (index(values(g:toggledict), sel) == -1) && (index(values(g:toggledict), sel) == -1)
    return
  else
    if (index(values(g:toggledict), sel) != -1)
      let word = (rev) ? (TogglePrevious(sel)) : (GetToggleWord(sel))
    else
      let word = (rev) ? (TogglePrevious(sel)) : (g:toggledict[sel])
    endif

    if a:case =~? 'upper'
      let word = Upcase(word)
    elseif a:case =~? 'capitalized'
      let word = Captialize(word)
    else
      let word = Downcase(word)
    endif

    let prevcol = col('.')
    exe 'silent! :s;\(\%#\V' . oldsel . '\);' . substitute(word, '&', '\\\&', 'g') . ';'
    exe 'normal! '.prevcol.'|'
  endif
endf
command! -register ToggleSelection call ToggleSelection()

fu! ToggleWord(...)
  let oldpos = getcurpos()
  call InnerSubword()

  " hack. not sure why it goes to col 1
  if (col('.') == 1) && (getline('.')[0] =~ '\s')
    call setpos('.', oldpos)
    normal! viw
  endif

  call ToggleSelection(a:1)
endf
