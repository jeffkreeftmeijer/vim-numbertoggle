" If the buffer is a command line buffer (invoked using 'q:', 'q/' or 'q?')
if(bufname('%') == '[Command Line]')
	" Call the needed functions
	call call(g:number_toggle#numbertoggle.source,[],{})
	call g:numbertoggle.disable()

	" Disable numbertoggle completely
	autocmd FocusLost * :call g:numbertoggle.disable()
	autocmd FocusGained * :call g:numbertoggle.disable()
	autocmd WinLeave * :call g:numbertoggle.disable()
	autocmd WinEnter * :call g:numbertoggle.disable()
	autocmd InsertEnter * :call g:numbertoggle.disable()
	autocmd InsertLeave * :call g:numbertoggle.disable()

	" Only use permanent line numbers
	set number
endif
