# vim-toggle
A fast, easy word toggler.

## How it works
When called, the current or nearest sub-word (camelCase, snake_case, or alpha/digit) is detected and used as a key to a dictionary containing complementary words. If you use the `c` command in (e.g. `ciw` or similar) to change a word to another, the words are added to the dictionary. If you change the new word again, the word is inserted into the toggle ring (circular linked list), so it will alternate between three (or more) words.

If the subword is an integer, it simply uses vim's built in `<C-A>` increment. If a single letter is selected, the next letter alphabetically is used by default.

Extra sub-word motions are included since most of the stuff was already required for this script, and they are very useful.

## Notes
A dictionary is included for common words, but is automatically updated as you work. If either the newly typed word or previous word are not found in the dictionary, they are inserted into to a toggle ring. If they both exist, nothing is updated. You can enable overwriting of dictionary entries with `let g:toggleopts['overwrite'] = 1`, which also has the side effect making all new toggles binary. The digit increment will not be overridden, but the single letter increments will be replaced.

By default, word comparison is case insensitive, but the case of the new word is matched to the previous.

To manually add your own toggles, `:call AddToggle(a, b)`. Automatically update toggles after a visual mode paste with:

    `vnoremap <silent> p p:call AddToggle(@0, @-)<CR>` 

You can also update toggles with most recent deletion / yank with `<leader><M-t>` (by default uses registers `@-` and `@0`)

If normal mode does not work for toggles that cannot be detected by the sub-word detection (e.g. it contains letters and punctuation), then selecting the text in visual mode first should work.

The list of words is contained in `plugin/toggle_words.vim` if you wish to modify or add your own entries.

## Default mappings
    
    nnoremap <silent> <leader><M-t> :call ToggleAdd(@0, @-)<CR>
    
    nnoremap <silent> <M-t> :ToggleWord<CR>
    nnoremap <silent> <M-T> :ToggleWordPrev<CR>
    
    vnoremap <silent> <M-t> :<C-u>ToggleWordVisual<CR>
    vnoremap <silent> <M-T> :<C-u>ToggleWordPrevVisual<CR>

## Other available mappings

    map <Plug>SubwordBeginLeft
    map <Plug>SubwordBeginRight
    map <Plug>SubwordEndLeft
    map <Plug>SubwordEndRight
    map <Plug>SubwordBoundaryLeft
    map <Plug>SubwordBoundaryRight
    vmap <Plug>VisualSubwordLeft
    vmap <Plug>VisualSubwordRight
    vmap <Plug>VisualSubwordExpand
    map <Plug>InnerSubword
    omap <Plug>InnerSubword
    vmap <Plug>VisualSubwordExpand
    nmap <Plug>ToggleWord
    vmap <Plug>ToggleWord
    nmap <Plug>ToggleWordPrev
    vmap <Plug>ToggleWordPrev
    
## Plans
Make toggles adapt to filetype
