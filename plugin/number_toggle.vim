" Prevent multi loads and disable in compatible mode
" check if vim version is at least 7.3 
" (relativenumber is not supported below)
if !has('autocmd') || exists('g:loaded_numbertoggle') || &cp || v:version < 703
	finish
endif

let g:loaded_numbertoggle=1

if exists('g:default_off') "{{{1

	if exists('g:NumberToggleOn')
		exec 'nnoremap <silent> ' . g:NumberToggleOn . ' :call call(g:number_toggle#numbertoggle.source,[],{})<CR>'
	else
		nnoremap <silent> <C-m> :call call(g:number_toggle#numbertoggle.source, [], {})<CR>
	endif

	finish

else "{{{1

	call call(g:number_toggle#numbertoggle.source, [], {})

endif
