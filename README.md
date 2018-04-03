# vim_toggle
A easy, fast word toggler.

## How it works
When called, the current or nearest sub-word (camelCase or snake_case) is detected and used as a key for a dictionary for an alternate word. If you use `ciw` or similar to change a word to another, the words are added to the dictionary. If you change the new word again, the word is inserted into the toggle ring, so it will alternate between three (or more) words.

## Notes
By default, word comparison is case insensitive, but the case of the new word is matched to the previous.

A dictionary is included for common words, but is automatically updated as work. If either the newly typed word or previous word are not found in the dictionary, they are added to a toggle ring. If they both exist, nothing is updated. You can enable overwriting of dictionary entries with `let g:toggleopts['overwrite'] = 1`

## Default mappings

    nnoremap <silent> <M-t> :ToggleWord<CR>
    vnoremap <silent> <M-t> :<C-u>ToggleSelection<CR>
