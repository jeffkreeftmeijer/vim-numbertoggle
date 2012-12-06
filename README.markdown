# numbertoggle

While Vim's relativenumber option is great, you probably don't want to use it all the time. numbertoggle allows you to quickly toggle between relative and absolute line numbers and cleverly switches when when focus is lost or gained or when switching between normal and insert mode.

## Installation

If you don't have a preferred installation method, I recommend installing [pathogen.vim](https://github.com/tpope/vim-pathogen), and then simply copy and paste:

    cd ~/.vim/bundle
    git clone git://github.com/jeffkreeftmeijer/vim-numbertoggle.git

Once help tags have been generated, you can view the manual with
`:help numbertoggle`.

## Settings

### Toggle trigger

By default, the key to toggle between line numbers (i.e. change from relative to permanent line numbers) is `Ctrl+n`. If you want to change this, you can put the following in your `.vimrc` file:<br />
`let g:NumberToggleTrigger=key-combo`

You would of course replace `key-combo` with whatever keys you want to press to toggle, for example:<br />
`let g:NumberToggleTrigger=<leader>tl`

### Disabling numbertoggle by default

By default, numbertoggle is always on. If you want to change this put the following in your `.vimrc` file:<br />
`let g:default_off=1`

This will disable it until you call it back on, or you delete that line and you restart Vim.

To call it back on, by default you can use `Ctrl+m` to enable it again, and it will work as if you never disabled it. To configure this keybinding, add the following to your `.vimrc` file:<br />
`let g:NumberToggleOn=key-combo`

You would of course replace `key-combo` with whatever keys you want to press to turn it back on, for example:<br />
`let g:NumberToggleTrigger=<leader>to`

## License
Copyright (c) Jeff Kreeftmeijer. Distributed under the same terms as Vim itself. See :help license.
