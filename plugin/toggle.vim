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
" vnoremap <silent> p p:call ToggleAdd(@0, @-)<CR>

