call number_toggle#NumberToggleOn()

if &buftype == 'nofile'
	call InsertEnter()
	autocmd InsertEnter * :call InsertEnter()
	autocmd InsertLeave * :call InsertEnter()
endif
