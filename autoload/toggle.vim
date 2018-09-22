let g:toggleopts = {'overwrite': 1, 'ignorecase': 1}

if !(exists('g:toggledict'))
  let g:toggledict = {}
endif

let s:path = resolve(expand('<sfile>:p'))
" exe 'so '.substitute(s:path, '\.vim$', '_words.vim', '')

" togglewords
if !exists('g:togglewords_initialized')

let g:togglewords_initialized = 1

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

      " \['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
      " \'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'],

let g:togglewords_vim = [
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

let g:togglewords_ruby = [
      \['if', 'elsif', 'else', 'end'],
      \['for', 'end'],
      \['while', 'end'],
      \['begin', 'rescue', 'ensure', 'end'],
      \['def', 'end'],
      \]

let g:togglewords_shell = [
      \['if', 'elif', 'else', 'fi'],
      \['case', 'esac'],
      \['for', 'done'],
      \['while', 'done'],
      \]


endif
" end togglewords
  
" exe 'so '.substitute(s:path, '\.vim$', '_subword.vim', '')
" subwords

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
" end subwords

" exe 'so '.substitute(s:path, '\.vim$', '_lcs.vim', '')
" lcs
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
" end lcs

command! -register ToggleWord call ToggleWord(1)
command! -register ToggleWordPrev call ToggleWord(-1)
command! -register ToggleWordVisual call ToggleSelection(1)
command! -register ToggleWordPrevVisual call ToggleSelection(-1)

nmap <Plug>ToggleWord :ToggleWord<CR>
nmap <Plug>ToggleWordPrev :ToggleWordPrev<CR>
vmap <Plug>ToggleWord :<C-u>ToggleWordVisual<CR>
vmap <Plug>ToggleWordPrev :<C-u>ToggleWordPrevVisual<CR>

nnoremap <silent> <M-t> :ToggleWord<CR>
nnoremap <silent> <M-T> :ToggleWordPrev<CR>
nnoremap <silent> <leader><M-t> :call ToggleAdd(@0, @-)<CR>
vnoremap <silent> <M-t> :<C-u>ToggleWordVisual<CR>
vnoremap <silent> <M-T> :<C-u>ToggleWordPrevVisual<CR>
