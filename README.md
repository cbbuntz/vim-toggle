# vim-toggle
A fast, easy word toggler.

## How it works
When called, the current or nearest sub-word (camelCase, snake_case, or alpha/digit) is detected and used as a key to a dictionary containing complementary words. If you use `ciw` or similar to change a word to another, the words are added to the dictionary. If you change the new word again, the word is inserted into the toggle ring, so it will alternate between three (or more) words. If the subword is an integer, it simply uses vim's built in `<C-A>` increment.

## Notes
A dictionary is included for common words, but is automatically updated as you work. If either the newly typed word or previous word are not found in the dictionary, they are inserted into to a toggle ring. If they both exist, nothing is updated. You can enable overwriting of dictionary entries with `let g:toggleopts['overwrite'] = 1`, which also has the side effect making all new toggles binary.

By default, word comparison is case insensitive, but the case of the new word is matched to the previous. You can enable case sensitivity with `let g:toggleopts['ignorecase'] = 0`, but this is untested and will cause all default toggles to not work for non-lowercase words.

The list of words is contained in `plugin/toggle_words.vim` if you wish to modify or add your own entries.

## Default mappings

    nnoremap <silent> <M-t> :ToggleWord<CR>
    vnoremap <silent> <M-t> :<C-u>ToggleSelection<CR>
