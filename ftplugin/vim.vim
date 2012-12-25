" If the buffer is a command line buffer (invoked using 'q:', 'q/' or 'q?')
if(bufname('%') == '[Command Line]')
	" Call the needed functions
	call call(g:number_toggle#numbertoggle.source,[],{})
	call g:numbertoggle.disable()

	" Disable numbertoggle completely
	augroup NumberToggle
		autocmd!
	augroup END
	augroup! NumberToggle

	" Only use permanent line numbers
	set number
endif
