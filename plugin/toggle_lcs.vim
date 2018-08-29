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
  let keys = keys(b:toggledict)
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
" nmap <C-T> :echo LCSKeyLine()<CR>
