" vim-numbertoggle - Automatic toggling between 'hybrid' and absolute line numbers
" Maintainer:        <https://jeffkreeftmeijer.com>
" Version:           2.1.1

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * call numbertoggle#toggle#Set_rnu()
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave  * call numbertoggle#toggle#Set_nornu()


  " CmdlineLeave and CmdlineEnter are new events. Older versions of 
  " vim and nvim don't have them.
  if exists('##CmdlineLeave')
    autocmd CmdlineLeave * call numbertoggle#toggle#Set_rnu()
  endif
   
  if exists('##CmdlineEnter')
    autocmd CmdlineEnter * call numbertoggle#toggle#Set_nornu()
  endif
augroup END

