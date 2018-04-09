function! numbertoggle#toggle#Set_rnu()
  if &nu
    set rnu
  endif
endfunction

function! numbertoggle#toggle#Set_nornu()
  if &nu
    set nornu
    redraw
  endif
endfunction
