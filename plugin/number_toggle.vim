" Prevent multi loads and disable in compatible mode
" check if vim version is at least 7.3 
" (relativenumber is not supported below)
if exists('g:loaded_numbertoggle') || &cp || v:version < 703
	finish
endif

let g:loaded_numbertoggle=1

if exists('g:default_off') "{{{1

	set nonumber
	set norelativenumber

	if exists('g:NumberToggleOn')
		exec "nnoremap <silent> " . g:NumberToggleOn . " :call number_toggle#NumberToggleOn()<cr>"
	else
		nnoremap <silent> <C-m> :call number_toggle#NumberToggleOn()<CR>
	endif

	finish

else "{{{1

	call number_toggle#NumberToggleOn()

endif
