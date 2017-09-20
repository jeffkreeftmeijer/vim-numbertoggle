# numbertoggle


In a buffer with "hybrid" line numbers (`:set number relativenumber`),
numbertoggle switches to absolute line numbers (`:set number norelativenumber`)
automatically when relative numbers don't make sense.

![vim-numbertoggle toggles between "hybrid" and absolute line numbers automatically](https://jeffkreeftmeijer.com/vim-number/toggle.gif)

Relative numbers are used in a buffer that has focus, and is in normal
mode, since that's where you move around. They're turned off when you switch
out of Vim, switch to another split, or when you go into insert mode.

## Installation

Using [vim-plug](https://github.com/junegunn/vim-plug)

1. Add `Plug 'jeffkreeftmeijer/vim-numbertoggle'` to `~/.vimrc` or 
  `~/.config/nvim/init.vim`
2. Run `:PlugInstall`
3. `:set number relativenumber`

Once help tags are generated, you can view the manual with `:help numbertoggle`.
