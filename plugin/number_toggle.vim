" Prevent multi loads and disable in compatible mode
" check if vim version is at least 7.3 
" (relativenumber is not supported below)
if exists('g:loaded_numbertoggle') || &cp || v:version < 703
	finish
endif
let g:loaded_numbertoggle = 1
let g:insertmode = 0
let g:focus = 1

" NumberToggle toggles between relative and absolute line numbers
function! NumberToggle()
	if(&relativenumber == 1)
		set number
	else
		set relativenumber
	endif
endfunc

function! UpdateMode()
	if(g:focus == 0)
		set number
	elseif(g:insertmode == 0)
		set relativenumber
	else
		set number
	end
endfunc

function! FocusGained()
	let g:focus = 1
	call UpdateMode()
endfunc

function! FocusLost()
	let g:focus = 0
	call UpdateMode()
endfunc

function! InsertLeave()
	let g:insertmode = 0
	call UpdateMode()
endfunc

function! InsertEnter()
	let g:insertmode = 1
	call UpdateMode()
endfunc


" Automatically set relative line numbers when opening a new document
autocmd BufNewFile * :call UpdateMode()
autocmd BufReadPost * :call UpdateMode()
autocmd FilterReadPost * :call UpdateMode()
autocmd FileReadPost * :call UpdateMode()

" Automatically switch to absolute numbers when focus is lost and switch back
" when the focus is regained.
autocmd FocusLost * :call FocusLost()
autocmd FocusGained * :call FocusGained()

" Switch to absolute line numbers when entering insert mode and switch back to
" relative line numbers when switching back to normal mode.
autocmd InsertEnter * :call InsertEnter()
autocmd InsertLeave * :call InsertLeave()

if exists('g:NumberToggleTrigger')
	exec "nnoremap <silent> " . g:NumberToggleTrigger . " :call NumberToggle()<cr>"
else
	nnoremap <silent> <C-n> :call NumberToggle()<cr>
endif
