" vim-numbertoggle - Automatic toggling between 'hybrid' and absolute line numbers
" Maintainer:        <https://jeffkreeftmeijer.com>
" Version:           2.1.1

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * call Set_rnu()
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave  * call Set_nornu()


  if exists('##CmdlineLeave')
    autocmd CmdlineLeave * call Set_rnu()
  endif
   
  if exists('##CmdlineEnter')
    call inputsave()
    autocmd CmdlineEnter * call Set_nornu()
    call inputrestore()
  endif

augroup END

function! Set_rnu()
  if &nu
    set rnu
  endif
endfunction

function! Set_nornu()
  if &nu
    set nornu
    " redraw!
  endif
endfunction
