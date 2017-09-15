# numbertoggle

Sets up "hybrid" line number mode (`:set number relativenumber`), and switches
to absolute line numbers (`:set number norelativenumber`) automatically when
relative numbers don't make sense.

Relative numbers are only used in a buffer that has focus, and is in normal
mode, since that's where you move around. They're turned off when you switch
out of Vim, switch to another split, or when you go into insert mode.

## Installation

Using [vim-plug](https://github.com/junegunn/vim-plug)

1. Add `Plug 'jeffkreeftmeijer/vim-numbertoggle'` to `~/.vimrc` or 
  `~/.config/nvim/init.vim`
2. Run `:PlugInstall`

Once help tags have been generated, you can view the manual with
`:help numbertoggle`.
