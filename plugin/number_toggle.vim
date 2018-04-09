" vim-number_toggle - Automatic toggling between 'hybrid' and absolute line numbers
" Maintainer:        <https://jeffkreeftmeijer.com>
" Version:           2.1.1

augroup number_toggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * call number_toggle#toggle#Set_rnu()
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave  * call number_toggle#toggle#Set_nornu()


  " CmdlineLeave and CmdlineEnter are new events. Older versions of 
  " vim and nvim don't have them.
  if exists('##CmdlineLeave')
    autocmd CmdlineLeave * call number_toggle#toggle#Set_rnu()
  endif
   
  if exists('##CmdlineEnter')
    autocmd CmdlineEnter * call number_toggle#toggle#Set_nornu()
  endif
augroup END

