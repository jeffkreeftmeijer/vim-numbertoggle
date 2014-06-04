" Prevent multi loads and disable in compatible mode
" check if vim version is at least 7.3
" (relativenumber is not supported below)
if exists('g:loaded_numbertoggle') || &cp || v:version < 703
    finish
endif
let g:loaded_numbertoggle = 1
if !exists("g:numbertoggle_show_current_line_number_in_relativenumber_mode")
    let g:numbertoggle_show_current_line_number_in_relativenumber_mode = 1
endif
if !exists("g:numbertoggle_enable_relativenumber_in_insert_mode")
    let g:numbertoggle_enable_relativenumber_in_insert_mode = 0
endif
if !exists("g:numbertoggle_ignore_filetypes")
    let g:numbertoggle_ignore_filetypes = ["filebeagle"]
endif
let s:insert_mode = 0
let s:focus = 1
let s:relativenumber_mode = 1

" Enables relative numbers.
function! s:EnableRelativeNumbers()
    if !g:numbertoggle_show_current_line_number_in_relativenumber_mode
        set nonumber
    else
        set number
    endif
    set relativenumber
endfunc

" Disables relative numbers.
function! s:DisableRelativeNumbers()
    set number
    set norelativenumber
endfunc

" NumberToggle toggles between relative and absolute line numbers
function! s:NumberToggle()
    if &relativenumber == 1
        call s:DisableRelativeNumbers()
        let s:relativenumber_mode = 0
    else
        call s:EnableRelativeNumbers()
        let s:relativenumber_mode = 1
    endif
endfunc

" Completely hides all numbers if showing;
" shows them again if not showing
function! s:NumberToggleShowHideAll()
    if &relativenumber || &number
        set nonumber
        set norelativenumber
    else
        set number
        set relativenumber
        call s:UpdateMode()
    endif
endfunc

function! s:UpdateMode()
    if index(g:numbertoggle_ignore_filetypes, &ft) != -1
        return
    endif
    if &number == 0 && &relativenumber == 0
        return
    end
    if s:focus == 0
        call s:DisableRelativeNumbers()
    elseif s:insert_mode == 0 && s:relativenumber_mode == 1
        call s:EnableRelativeNumbers()
    elseif s:insert_mode == 1  && g:numbertoggle_enable_relativenumber_in_insert_mode
        call s:EnableRelativeNumbers()
    else
        call s:DisableRelativeNumbers()
    end

    if !exists("&numberwidth") || &numberwidth <= 4
        " Avoid changing actual width of the number column with each jump between
        " number and relativenumber:
        let &numberwidth = max([4, 1+len(line('$'))])
    else
        " Explanation of the calculation:
        " - Add 1 to the calculated maximal width to make room for the space
        " - Assume 4 as the minimum desired width if &numberwidth is not set or is
        "   smaller than 4
        let &numberwidth = max([&numberwidth, 1+len(line('$'))])
    endif
endfunc

function! s:FocusGained()
    let s:focus = 1
    call s:UpdateMode()
endfunc

function! s:FocusLost()
    let s:focus = 0
    call s:UpdateMode()
endfunc

function! s:InsertLeave()
    let s:insert_mode = 0
    call s:UpdateMode()
endfunc

function! s:InsertEnter()
    let s:insert_mode = 1
    call s:UpdateMode()
endfunc

if has("autocmd")
    augroup NumberToggle
        autocmd!
        " Automatically set relative line numbers when opening a new document
        autocmd BufNewFile * :call <SID>UpdateMode()
        autocmd BufReadPost * :call <SID>UpdateMode()
        autocmd FilterReadPost * :call <SID>UpdateMode()
        autocmd FileReadPost * :call <SID>UpdateMode()

        " Automatically switch to absolute numbers when focus is lost and switch back
        " when the focus is regained.
        autocmd FocusLost * :call <SID>FocusLost()
        autocmd FocusGained * :call <SID>FocusGained()
        autocmd WinLeave * :call <SID>FocusLost()
        autocmd WinEnter * :call <SID>FocusGained()

        " Switch to absolute line numbers when the window loses focus and switch back
        " to relative line numbers when the focus is regained.
        autocmd WinLeave * :call <SID>FocusLost()
        autocmd WinEnter * :call <SID>FocusGained()

        " Switch to absolute line numbers when entering insert mode and switch back to
        " relative line numbers when switching back to normal mode.
        autocmd InsertEnter * :call <SID>InsertEnter()
        autocmd InsertLeave * :call <SID>InsertLeave()
    augroup end
endif

" ensures default behavior / backward compatibility
if ! exists ( 'g:UseNumberToggleTrigger' )
    let g:UseNumberToggleTrigger = 1
endif

" Plugin Key mapping to toggle NumberToggle
nnoremap <silent> <Plug>NumberToggleTrigger :call <SID>NumberToggle()<CR>
nnoremap <silent> <Plug>NumberToggleShowHideAll :call <SID>NumberToggleShowHideAll()<CR>

" Define key mapping
if exists('g:NumberToggleTrigger')
    execute "nmap <silent> " . g:NumberToggleTrigger  . " <Plug>NumberToggleTrigger"
elseif g:UseNumberToggleTrigger && !hasmapto("<Plug>NumberToggleTrigger")
    nmap <silent> <C-n> <Plug>NumberToggleTrigger
endif
