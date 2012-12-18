let g:number_toggle#numbertoggle={}

function! g:number_toggle#numbertoggle.source() "{{{1
	" Initialize this function, for when deactivated
	let g:numbertoggle={}

	" Set some variables used by functions
	let s:numbertoggle_insertmode=0
	let s:numbertoggle_focus=1

	" Undefine 'g:default_off' in order to use this function with no problems
	if exists('g:default_off')
		unlet g:default_off
	endif

	" Functions {{{2

	" .toggle() toggles between relative and absolute line numbers, depending
	" on which one is currently set
	function g:numbertoggle.toggle()
		if(&relativenumber == 1)
			set number
		else
			set relativenumber
		endif
	endfunction

	" This is the core function, it changes the method depending on some
	" variables, every function uses it
	function g:numbertoggle.updatemode()
		" If invert mode is set
		if exists('g:numbertoggle_invert')
			if(s:numbertoggle_focus == 0)
				set relativenumber
			elseif(s:numbertoggle_insertmode == 0)
				set number
			else
				set relativenumber
			endif
		endif

		" If invert mode is not set
		if !exists('g:numbertoggle_invert')
			if(s:numbertoggle_focus == 0)
				set number
			elseif(s:numbertoggle_insertmode == 0)
				set relativenumber
			else
				set number
			endif
		endif
	endfunction

	" A way to disable the plugin, if it ever comes to that
	function g:numbertoggle.disable()
		set nonumber
		set norelativenumber
	endfunction

	" .focusl() is used for when you lose focus
	function g:numbertoggle.focusl()
		let s:numbertoggle_focus=0
		call g:numbertoggle.updatemode()
	endfunction

	" .focusg() is used for when you regain focus
	function g:numbertoggle.focusg()
		let s:numbertoggle_focus=1
		call g:numbertoggle.updatemode()
	endfunction

	" .insertl() is used for when you leave insert mode
	function g:numbertoggle.insertl()
		let s:numbertoggle_insertmode=0
		call g:numbertoggle.updatemode()
	endfunction

	" .inserte() if for when you enter insert mode
	function g:numbertoggle.inserte()
		let s:numbertoggle_insertmode=1
		call g:numbertoggle.updatemode()
	endfunction

	" }}}2

	augroup NumberToggle
		autocmd!

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

	" Check if it was previously turned off, if it was then when turned on
	" make sure to turn on line numbers, and make it so that it wasn't
	" previously turned on.
	if exists('g:numbertoggle_previouslyon')
		if g:numbertoggle_previouslyon == 1
			call g:numbertoggle.updatemode()
			let g:numbertoggle_previously=0
		endif
	endif

endfunction "}}}1

function! g:number_toggle#numbertoggle.unload() "{{{1

	if exists('g:number_toggle#numbertoggle.source()')

		" Undefine the augroup used for plugin functionality
		augroup NumberToggle
			autocmd!
		augroup END
		augroup! NumberToggle

		" Disable any options that may have been set
		set nonumber
		set norelativenumber

		" Get rid of everything that the .source() function set
		execute 'nunmap' s:numbertoggle_lhs
		unlet g:numbertoggle
		unlet s:numbertoggle_insertmode
		unlet s:numbertoggle_focus
		unlet s:numbertoggle_lhs

		" Set the default line numbers for when it is turned off.
		if exists('g:numbertoggle_defaultmodeoff')
			exec 'set ' . g:numbertoggle_defaultmodeoff
		endif

		" Make sure numbertoggle knows it has previously been on and has been
		" turned off.
		let g:numbertoggle_previouslyon=1

	endif

endfunction "}}}1
