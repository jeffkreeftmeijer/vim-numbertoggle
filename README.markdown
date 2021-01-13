# numbertoggle


In a buffer with "hybrid" line numbers (`:set number relativenumber`),
numbertoggle switches to absolute line numbers (`:set number norelativenumber`)
automatically when relative numbers don't make sense.

![vim-numbertoggle toggles between "hybrid" and absolute line numbers automatically](https://jeffkreeftmeijer.com/vim-number/toggle.gif)

Relative numbers are used in a buffer that has focus, and is in normal
mode, since that's where you move around. They're turned off when you switch
out of Vim, switch to another split, or when you go into insert mode.

## Installation

Using Vim's package manager:

1. `$ git clone git@github.com:jeffkreeftmeijer/vim-numbertoggle.git ~/.vim/pack/plugins/start/vim-numbertoggle`
2. `:set number relativenumber`

Once help tags are generated, you can view the manual with `:help numbertoggle`.

## tmux

If you use tmux, add `set-option -g focus-events on` to your tmux config (`~/.tmux.conf`) (https://github.com/jeffkreeftmeijer/vim-numbertoggle/issues/45).
