# Introduction

While Vim's relativenumber option is great, you probably don't want to use
it all the time. numbertoggle allows you to quickly toggle between relative
and absolute line numbers and cleverly switches when when focus is lost or
gained or when switching between normal and insert mode.

For more information:
http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement

## Functionality

numbertoggle provides the following functionality:

- Very lightweight, not loaded unless you enable it by default or you turn it on after disabling it. As if it didn't exist if it's disabled.
- Automatic switching between permanent and relative line numbers.
  - Switches to relative line numbers when in normal mode.
  - Switches to permanent line numbers when in insert mode.
  - Switches to relative line numbers when the buffer or window is in focus.
  - Switches to permanent line numbers when the buffer or window is not in focus.
- Recognizes certain buffers and uses only a certain line style on it.
  - Recognizes `[Command Line]` buffers which can be invoked using `q:`, `q/` or `q?` and it automatically uses permanent line numbers exclusively, in order to be able to see which entry in the history it is.
  - Recognizes `[Vundle] Installer` buffers which can be invoked using `:BundleInstall` and `:BundleUpdate` and only uses permanent line numbers on them, for you to know what amount of plugins Vundle is loading, and how many it has processed.
- Allows you to turn it off or on at your command (literally).
- Allows you to disable it by default until you need it, and then you can disable it again if you want.
- Allows you to turn it off and on or toggle between relative and permanent line numbers, and all of these are configurable to a key mapping.

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

## Dependencies

In this section I will list some of the plugins on which numbertoggle may depend, or that would be very recommended to have:

- vitality by sjl: https://github.com/sjl/vitality.vim <br />
It's pretty much a must if you use iTerm or tmux and want to be able to use numbertoggle's lose focus or regain focus functionalities. Otherwise it's just a nice extra.

# Settings

In this section I'm gonna offer you some of the things that can be configured
for numbertoggle.

## Disabling numbertoggle by default

By default, numbertoggle is always on. If you want to change this put the following in your `.vimrc` file:
```viml
let g:numbertoggle_defaultoff=1
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
g:NumberToggleOff
g:NumberToggleTrigger
g:NumberToggleOn
```

They control the respective mappings in their respective order.

## Enabling invert mode

If you want to enable invert mode, then all you gotta do is add the following
to your .vimrc file:
```viml
let g:numbertoggle_invert=1
```

What is invert mode? Basically, it inverts the effects, so insert mode has
relative line numbers while command mode has permanent line numbers, etc.

## Default mode

Just to clarify something, this default mmode is not when turned off, but rather for when it is turned off.

When numbertoggle is turned off it stops having line numbers completely. If you prefer it to have relative or permanent line numbers when turned off you can now specify this in the following way:
```viml
let g:numbertoggle_defaultmodeoff = 'number'
```

This would achieve the following as a result:
```viml
set number
```

It's basically setting whatever string you input there, so it can also be a useful event if you like.

This feature would also affect the default startup mode, whenever you disable numbertoggle's functionality by default, whatever mode specified here will be used, so it's useful in a manner of ways.

# License

Copyright 2012 [Jeff Kreeftmeijer](http://jeffkreeftmeijer.com/). Distributed under the [same terms as Vim itself][3]. See `:help license`.

# Credits

Thanks to:

- [@markus1189][@1] - For commits [93e1865b4d][sha1], [dcfff5a2e6][sha2] and [c07baef29c][sha3].
- [@reedriley][@2] - For commits [6ae79447a1][sha4] to [592475df54][sha5].
- [@Greduan][@3] - For complete re-write, making it more efficient. For improving docs. For lots of added features. For commits from [192a4e1353][sha6] to [0e812d1de7][sha7].

[1]: http://www.vim.org/scripts/script.php?script_id=2332
[2]: https://github.com/gmarik/vundle
[3]: http://vimdoc.sourceforge.net/htmldoc/uganda.html#license

[@1]: https://github.com/markus1189
[@2]: https://github.com/reedriley
[@3]: https://github.com/Greduan

[issue5]: https://github.com/jeffkreeftmeijer/vim-numbertoggle/issues/5
[issue6]: https://github.com/jeffkreeftmeijer/vim-numbertoggle/issues/6

[sha1]: https://github.com/Greduan/vim-numbertoggle/commit/93e1865b4db19811b0276c9c6505ad40a8ee7742
[sha2]: https://github.com/Greduan/vim-numbertoggle/commit/dcfff5a2e67f0cbba2c686446c174bc59436d90d
[sha3]: https://github.com/Greduan/vim-numbertoggle/commit/c07baef29c3caf7e4b38af2d0e2d10bb460ffe22

[sha4]: https://github.com/Greduan/vim-numbertoggle/commit/6ae79447a15704c5442cc353b9781b36d3f28c5e
[sha5]: https://github.com/Greduan/vim-numbertoggle/commit/592475df545f125054e5e7eb135c04d7f38d8329

[sha6]: https://github.com/Greduan/vim-numbertoggle/commit/192a4e13538207f9f9f005be8204bcdc2fd52b2b
[sha7]: https://github.com/Greduan/vim-numbertoggle/commit/0e812d1de7a447365bca204ce1363ad9818bc662
