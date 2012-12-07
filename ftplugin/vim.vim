if &buftype == 'nofile'
	call number_toggle#NumberToggleOn()
	call InsertEnter()
	autocmd InsertEnter * :call InsertEnter()
	autocmd InsertLeave * :call InsertEnter()
endif
