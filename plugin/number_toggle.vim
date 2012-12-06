" Prevent multi loads and disable in compatible mode
" check if vim version is at least 7.3 
" (relativenumber is not supported below)
if exists('g:loaded_numbertoggle') || &cp || v:version < 703
	finish
endif

let g:loaded_numbertoggle = 1
let g:insertmode = 0
let g:focus = 1

if exists('g:default_off') "{{{1

	set nonumber
	set norelativenumber

	if exists('g:NumberToggleOn')
		exec "nnoremap <silent> " . g:NumberToggleOn . " :call NumberToggleOn()<cr>"
	else
		nnoremap <silent> <C-m> :call NumberToggleOn()<cr>
	endif

	" Functions {{{2
	" NumberToggle toggles between relative and absolute line numbers
	function! NumberToggle()
		if(&relativenumber == 1)
			set number
		else
			set relativenumber
		endif
	endfunc

	function! UpdateMode()
		if(g:focus == 0)
			set number
		elseif(g:insertmode == 0)
			set relativenumber
		else
			set number
		end
	endfunc

	function! FocusGained()
		let g:focus = 1
		call UpdateMode()
	endfunc

	function! FocusLost()
		let g:focus = 0
		call UpdateMode()
	endfunc

	function! InsertLeave()
		let g:insertmode = 0
		call UpdateMode()
	endfunc

	function! InsertEnter()
		let g:insertmode = 1
		call UpdateMode()
	endfunc
	" }}}2

	function NumberToggleOn()
		if exists('g:default_off')
			unlet g:default_off

			set relativenumber

			" Automatically set relative line numbers when opening a new document
			autocmd BufNewFile * :call UpdateMode()
			autocmd BufReadPost * :call UpdateMode()
			autocmd FilterReadPost * :call UpdateMode()
			autocmd FileReadPost * :call UpdateMode()

			" Automatically switch to absolute numbers when input focus is lost and switch
			" back to relative line numbers when the input focus is regained. Only for GUI
			" versions, and some console versions where this can be detected.
			autocmd FocusLost * :call FocusLost()
			autocmd FocusGained * :call FocusGained()

			" Automatically switch to absolute line numbers when window or buffer focus is
			" lost, and switch back to relative line numbers when the window or buffer
			" focus is regained.
			autocmd WinLeave * :call FocusLost()
			autocmd WinEnter * :call FocusGained()

			" Switch to absolute line numbers when entering insert mode and switch back to
			" relative line numbers when switching back to normal mode.
			autocmd InsertEnter * :call InsertEnter()
			autocmd InsertLeave * :call InsertLeave()

			if exists('g:NumberToggleTrigger')
				exec "nnoremap <silent> " . g:NumberToggleTrigger . " :call NumberToggle()<cr>"
			else
				nnoremap <silent> <C-n> :call NumberToggle()<cr>
			endif
		endif
	endfunc

	finish

else "{{{1

	" Functions {{{2
	" NumberToggle toggles between relative and absolute line numbers
	function! NumberToggle()
		if(&relativenumber == 1)
			set number
		else
			set relativenumber
		endif
	endfunc

	function! UpdateMode()
		if(g:focus == 0)
			set number
		elseif(g:insertmode == 0)
			set relativenumber
		else
			set number
		end
	endfunc

	function! FocusGained()
		let g:focus = 1
		call UpdateMode()
	endfunc

	function! FocusLost()
		let g:focus = 0
		call UpdateMode()
	endfunc

	function! InsertLeave()
		let g:insertmode = 0
		call UpdateMode()
	endfunc

	function! InsertEnter()
		let g:insertmode = 1
		call UpdateMode()
	endfunc
	" }}}2

	" Automatically set relative line numbers when opening a new document
	autocmd BufNewFile * :call UpdateMode()
	autocmd BufReadPost * :call UpdateMode()
	autocmd FilterReadPost * :call UpdateMode()
	autocmd FileReadPost * :call UpdateMode()

	" Automatically switch to absolute numbers when input focus is lost and switch
	" back to relative line numbers when the input focus is regained. Only for GUI
	" versions, and some console versions where this can be detected.
	autocmd FocusLost * :call FocusLost()
	autocmd FocusGained * :call FocusGained()

	" Automatically switch to absolute line numbers when window or buffer focus is
	" lost, and switch back to relative line numbers when the window or buffer
	" focus is regained.
	autocmd WinLeave * :call FocusLost()
	autocmd WinEnter * :call FocusGained()

	" Switch to absolute line numbers when entering insert mode and switch back to
	" relative line numbers when switching back to normal mode.
	autocmd InsertEnter * :call InsertEnter()
	autocmd InsertLeave * :call InsertLeave()

	if exists('g:NumberToggleTrigger')
		exec "nnoremap <silent> " . g:NumberToggleTrigger . " :call NumberToggle()<cr>"
	else
		nnoremap <silent> <C-n> :call NumberToggle()<cr>
	endif

	if exists('g:NumberToggleOn')
		exec "nnoremap <silent> " . g:NumberToggleOn . " :call NumberToggleOn()<cr>"
	else
		nnoremap <silent> <C-m> :call NumberToggleOn()<cr>
	endif
endif
