# Introduction

While Vim's relativenumber option is great, you probably don't want to use
it all the time. numbertoggle allows you to quickly toggle between relative
and absolute line numbers and cleverly switches when when focus is lost or
gained or when switching between normal and insert mode.

For more information:
http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement

## Functionality

numbertoggle provides the following functionality:

* Switches to relative line numbers when in normal mode.
* Switches to permanent line numbers when in insert mode.
* Switches to relative line numbers when the buffer or window is in focus.
* Switches to permanent line numbers when the buffer or window is not in focus.
* Recognizes `[Command Line]` which can be invoked using `q:`, `q/` or `q?` and it automatically uses permanent line numbers exclusively, in order to be able to see which entry in the history it is.
* Allows you to turn it off or on at your command (literally).
* Allows you to disable it by default until you need it, and then you can disable it again if you want.
* Allows you to turn it off and on or toggle between relative and permanent line numbers, and all of these are configurable to a key mapping.

# Installation

If you don't have a preffered installation method, I recommend using [Pathogen][1] or [Vundle][2].

If you prefer Pathogen you can copy&paste the following into your Terminal:

```sh
cd ~/.vim/bundle
git clone git://github.com/jeffkreeftmeijer/vim-numbertoggle.git
```

If you prefer Vundle you can copy&paste the following into your .vimrc file:

```viml
Bundle 'jeffkreeftmeijer/vim-numbertoggle'
```

Once that is done, and you startup Vim, the help docs' tags will be generated and you can view the manual with `:h numbertoggle` to view most of what you're seeing right now.

# Settings

In this section I'm gonna offer you some of the things that can be configured
for numbertoggle.

## Disabling numbertoggle by default

By default, numbertoggle is always on. If you want to change this put the following in your `.vimrc` file:
```viml
let g:default_off=1
```

This will disable it until you call it back on, or you delete that line and you restart Vim.

To call it back on, by default you can use `Ctrl+m` to enable it again, and it will work as if you never disabled it. To configure this keybinding, add the following to your `.vimrc` file:
```viml
let g:NumberToggleOn='key-combo'
```

You would of course replace `key-combo` with whatever keys you want to press to turn it back on, for example:
```viml
let g:NumberToggleTrigger='<leader>tlo'
```

## Turning numbertoggle on/off at will

By default numbertoggle provides the following keymappings:<br />
`Ctrl+b` which turns numbertoggle completely off, and also line numbers.<br />
`Ctrl+n` which toggles between permanent and relative line numbers, in whatever mode you are.<br />
`Ctrl+m` which turns on numbertoggle, if it is off by default or if it was turned off with `Ctrl+b`.

You can configure all of these mappings with the following variables:
```viml
`g:NumberToggleOff`
`g:NumberToggleTrigger`
`g:NumberToggleOn`
```

They control the respective mappings in their respective order.

# License

Copyright 2012 [Jeff Kreeftmeijer](http://jeffkreeftmeijer.com/). Distributed under the [same terms as Vim itself][3]. See `:help license`.

# Credits

Thanks to:

* [@markus1189][@1] - For adding a check to make sure current version of Vim is compatible with numbertoggle. And for preventing plugin reloading. And for adding the `<silent>` flat to NumberToggle() calls. Adding .gitignore entry for docs' tags.
* [@reedriley][@2] - For fixing inconsistent whitespace, fixing bug when regaining focus while in insert mode and for adding autocmds for setting appropiate mode when editing a file.
* [@Greduan][@3] - For fixing issues [#5][issue5] and [#6][issue6]. For adding ability to turn on and off numbertoggle, at will. For making it more efficient. For improving documentation and REAMDE file.

[1]: http://www.vim.org/scripts/script.php?script_id=2332
[2]: https://github.com/gmarik/vundle
[3]: http://vimdoc.sourceforge.net/htmldoc/uganda.html#license

[@1]: https://github.com/markus1189
[@2]: https://github.com/reedriley
[@3]: https://github.com/Greduan

[issue5]: https://github.com/jeffkreeftmeijer/vim-numbertoggle/issues/5
[issue6]: https://github.com/jeffkreeftmeijer/vim-numbertoggle/issues/6
