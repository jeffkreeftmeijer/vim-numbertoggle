let g:insertmode = 0
let g:focus = 1

function! number_toggle#g:numbertoggle.source() "{{{1
	if exists('g:default_off')
		unlet g:default_off
	endif

	set relativenumber

	" Functions {{{2
	" NumberToggle toggles between relative and absolute line numbers
	function g:numbertoggle.toggle()
		if(&relativenumber == 1)
			set number
		else
			set relativenumber
		endif
	endfunc

	function g:numbertoggle.updatemode()
		if(g:focus == 0)
			set number
		elseif(g:insertmode == 0)
			set relativenumber
		else
			set number
		end
	endfunc

	function g:numbertoggle.focusg()
		let g:focus = 1
		call g:numbertoggle.updatemode()
	endfunc

	function g:numbertoggle.focusl()
		let g:focus = 0
		call g:numbertoggle.updatemode()
	endfunc

	function g:numbertoggle.insertl()
		let g:insertmode = 0
		call g:numbertoggle.updatemode()
	endfunc

	function g:numbertoggle.inserte()
		let g:insertmode = 1
		call g:numbertoggle.updatemode()
	endfunc
	" }}}2

	augroup! NumberToggle
		" Automatically set relative line numbers when opening a new document
		autocmd BufNewFile * :call g:numbertoggle.updatemode()
		autocmd BufReadPost * :call g:numbertoggle.updatemode()
		autocmd FilterReadPost * :call g:numbertoggle.updatemode()
		autocmd FileReadPost * :call g:numbertoggle.updatemode()

		" Automatically switch to absolute numbers when input focus is lost and switch
		" back to relative line numbers when the input focus is regained. Only for GUI
		" versions, and some console versions where this can be detected.
		autocmd FocusLost * :call g:numbertoggle.focusl()
		autocmd FocusGained * :call g:numbertoggle.focusg()

		" Automatically switch to absolute line numbers when window or buffer focus is
		" lost, and switch back to relative line numbers when the window or buffer
		" focus is regained.
		autocmd WinLeave * :call g:numbertoggle.focusl()
		autocmd WinEnter * :call g:numbertoggle.focusg()

		" Switch to absolute line numbers when entering insert mode and switch back to
		" relative line numbers when switching back to normal mode.
		autocmd InsertEnter * :call g:numbertoggle.inserte()
		autocmd InsertLeave * :call g:numbertoggle.insertl()
	augroup END

	let s:plugin_lhs=exists('g:NumberToggleTrigger') ? g:NumberToggleTrigger : '<C-n>'
	exec 'nnoremap <silent> ' . s:plugin_lhs . ' :call number_toggle#numbertoggle.source()<CR>'
endfunction "}}}1

function! number_toggle#g:numbertoggle.unload() "{{{1
	augroup! NumberToggle
		autocmd!
	augroup END
	augroup! NumberToggle
	execute 'nunmap' s:plugin_lhs
	unlet g:numbertoggle
	unlet g:loaded_numbertoggle
	unlet g:insertmode
	unlet g:focus
	unlet s:plugin_lhs
endfunction "}}}1
