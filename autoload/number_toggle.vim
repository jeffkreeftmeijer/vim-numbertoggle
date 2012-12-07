let g:insertmode = 0
let g:focus = 1

function! number_toggle#NumberToggleOn() "{{{1
	if exists('g:default_off')
		unlet g:default_off
	endif

	set relativenumber

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

	augroup! NumberToggle
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
	augroup END

	let s:plugin_lhs=exists('g:NumberToggleTrigger') ? g:NumberToggleTrigger : '<C-n>'
	exec 'nnoremap <silent> ' . s:plugin_lhs . ' :call number_toggle#NumberToggle()<CR>'
endfunction "}}}1

let g:numbertoggle={}

function g:numbertoggle.unload() "{{{1
	augroup! NumberToggle
		autocmd!
	augroup END
	augroup! NumberToggle
	execute 'nunmap' s:plugin_lhs
	delfunction NumberToggle
	delfunction UpdateMode
	delfunction FocusGained
	delfunction FocusLost
	delfunction InsertLeave
	delfunction InsertEnter
	unlet g:loaded_numbertoggle
	unlet g:insertmode
	unlet g:focus
	unlet s:plugin_lhs
endfunction "}}}1
