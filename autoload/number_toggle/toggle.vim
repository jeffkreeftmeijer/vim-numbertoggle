
function! number_toggle#toggle#Set_rnu()
  if &nu
    set rnu
  endif
endfunction

function! number_toggle#toggle#Set_nornu()
  if &nu
    set nornu
    redraw
  endif
endfunction
