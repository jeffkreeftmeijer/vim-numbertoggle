" vim-numbertoggle - Automatic toggling between 'hybrid' and absolute line numbers
" Maintainer:        <https://jeffkreeftmeijer.com>
" Version:           2.1.1

let s:rnu_events = "BufEnter,FocusGained,InsertLeave,WinEnter" 
if exists('##CmdlineLeave')
  let s:rnu_events = s:rnu_events . ",CmdlineLeave"
endif

let s:nornu_events = "BufLeave,FocusLost,InsertEnter,WinLeave"
if exists('##CmdlineEnter')
  let s:nornu_events = s:nornu_events . ",CmdlineEnter"
endif

augroup numbertoggle
  autocmd!
  exec "autocmd " . s:rnu_events   . ' * if &nu | set rnu   | endif'
  exec "autocmd " . s:nornu_events . ' * if &nu | set nornu | redraw | endif'
augroup END

