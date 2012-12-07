if &buftype == 'nofile'
	call number_toggle#g:numbertoggle.source()
	call g:numbertoggle.inserte()
	autocmd InsertEnter * :call g:numbertoggle.inserte()
	autocmd InsertLeave * :call g:numbertoggle.inserte()
endif
