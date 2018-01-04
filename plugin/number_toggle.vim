" vim-numbertoggle - Automatic toggling between 'hybrid' and absolute line numbers
" Maintainer:        <https://jeffkreeftmeijer.com>
" Version:           2.1.1

augroup numbertoggle
  autocmd!
  autocmd BufEnter,CmdlineLeave,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,CmdlineEnter,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | redraw! | endif
augroup END
