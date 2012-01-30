" NumberToggle toggles between relative and absolute line numbers
function! NumberToggle()
	if(&relativenumber == 1)
		set number
	else
		set relativenumber
	endif
endfunc

" Automatically switch to absolute numbers when focus is lost and switch back
" when the focus is regained.
:au FocusLost * :set number
:au FocusGained * :set relativenumber

" Switch to absolute line numbers when entering insert mode and switch back to
" relative line numbers when switching back to normal mode.
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

if exists('g:NumberToggleTrigger')
  exec "nnoremap " . g:NumberToggleTrigger . " :call NumberToggle()<cr>"
else
  nnoremap <C-n> :call NumberToggle()<cr>
endif
