let g:insertmode = 0
let g:focus = 1

function! number_toggle#NumberToggleOn()
	if exists('g:default_off')
		unlet g:default_off
	endif

	set relativenumber

	" Functions {{{1
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
	" }}}1

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
		exec "nnoremap <silent> " . g:NumberToggleTrigger . " :call number_toggle#NumberToggle()<cr>"
	else
		nnoremap <silent> <C-n> :call number_toggle#NumberToggle()<CR>
	endif
endfunc
