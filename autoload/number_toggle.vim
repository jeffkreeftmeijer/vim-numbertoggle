let g:number_toggle#numbertoggle={}

function! g:number_toggle#numbertoggle.source() "{{{1
	let g:numbertoggle={}
	let s:numbertoggle_insertmode=0
	let s:numbertoggle_focus=1

	if exists('g:default_off')
		unlet g:default_off
	endif

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
		if exists('g:numbertoggle_invert')
			if(s:numbertoggle_focus == 0)
				set relativenumber
			elseif(s:numbertoggle_insertmode == 0)
				set number
			else
				set relativenumber
			endif
		endif

		if !exists('g:numbertoggle_invert')
			if(s:numbertoggle_focus == 0)
				set number
			elseif(s:numbertoggle_insertmode == 0)
				set relativenumber
			else
				set number
			endif
		endif
	endfunc

	function g:numbertoggle.focusl()
		let s:numbertoggle_focus=0
		call g:numbertoggle.updatemode()
	endfunc

	function g:numbertoggle.focusg()
		let s:numbertoggle_focus=1
		call g:numbertoggle.updatemode()
	endfunc

	function g:numbertoggle.insertl()
		let s:numbertoggle_insertmode=0
		call g:numbertoggle.updatemode()
	endfunc

	function g:numbertoggle.inserte()
		let s:numbertoggle_insertmode=1
		call g:numbertoggle.updatemode()
	endfunc
	" }}}2

	" Automatically set relative line numbers when opening a new document.
	autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost * :call g:numbertoggle.updatemode()

	" Automatically switch to absolute numbers when input focus is lost
	" and switch back to relative line numbers when the input focus is
	" regained. Only for GUI versions, and some console versions where
	" this can be detected. This behavior will be opposite if invert mode
	" is on.
	autocmd FocusLost * :call g:numbertoggle.focusl()
	autocmd FocusGained * :call g:numbertoggle.focusg()

	" Automatically switch to absolute line numbers when window or buffer
	" focus is lost, and switch back to relative line numbers when the
	" window or buffer focus is regained. This behavior will be opposite
	" if invert mode is on.
	autocmd WinLeave * :call g:numbertoggle.focusl()
	autocmd WinEnter * :call g:numbertoggle.focusg()

	" Switch to absolute line numbers when entering insert mode and switch
	" back to relative line numbers when switching back to normal mode.
	" This behaviour will be opposite if invert mode is on.
	autocmd InsertEnter * :call g:numbertoggle.inserte()
	autocmd InsertLeave * :call g:numbertoggle.insertl()
	augroup END

	let s:numbertoggle_lhs=exists('g:NumberToggleTrigger') ? g:NumberToggleTrigger : '<C-n>'
	exec 'nnoremap <silent> ' . s:numbertoggle_lhs . ' :call g:numbertoggle.toggle()<CR>'

	let s:numbertoggle_lhs=exists('g:NumberToggleOff') ?g:NumberToggleOff : '<C-b>'
	exec 'nnoremap <silent> ' . s:numbertoggle_lhs . ' :call call(g:number_toggle#numbertoggle.unload, [], {})<CR>'

endfunction

function! g:number_toggle#numbertoggle.unload() "{{{1
	augroup NumberToggle
		autocmd!
	augroup END
	augroup! NumberToggle

	set nonumber
	set norelativenumber

	execute 'nunmap' s:numbertoggle_lhs
	unlet g:numbertoggle
	unlet s:numbertoggle_insertmode
	unlet s:numbertoggle_focus
	unlet g:numbertoggle_invert
	unlet s:numbertoggle_lhs
endfunction "}}}1
