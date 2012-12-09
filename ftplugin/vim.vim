if(bufname('%') == '[Command Line]')
	call call(g:number_toggle#numbertoggle.source,[],{})
	call g:numbertoggle.disable()

	autocmd FocusLost * :call g:numbertoggle.disable()
	autocmd FocusGained * :call g:numbertoggle.disable()
	autocmd WinLeave * :call g:numbertoggle.disable()
	autocmd WinEnter * :call g:numbertoggle.disable()
	autocmd InsertEnter * :call g:numbertoggle.disable()
	autocmd InsertLeave * :call g:numbertoggle.disable()

	set number
endif

if(bufname('%') == '-MiniBufExplorer-')
	call call(g:number_toggle#numbertoggle.source,[],{})
	call g:numbertoggle.disable()

	autocmd FocusLost * :call g:numbertoggle.disable()
	autocmd FocusGained * :call g:numbertoggle.disable()
	autocmd WinLeave * :call g:numbertoggle.disable()
	autocmd WinEnter * :call g:numbertoggle.disable()
	autocmd InsertEnter * :call g:numbertoggle.disable()
	autocmd InsertLeave * :call g:numbertoggle.disable()
endif
