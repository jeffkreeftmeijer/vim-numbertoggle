if &buftype == 'nofile'
	call call(g:number_toggle#numbertoggle.source,[],{})
	call g:numbertoggle.inserte()
	autocmd InsertEnter * :call g:numbertoggle.inserte()
	autocmd InsertLeave * :call g:numbertoggle.inserte()
endif
