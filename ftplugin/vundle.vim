" If the buffer is Vundle's installer buffer
if(bufname('%') == '[Vundle] Installer')
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
