<h1 align="center"><code>clipb.kak</code></h1>
<p align="center">Clipboard managers warper for Kakoune</p>
<p align="center"><img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/160/twitter/281/clipboard_1f4cb.png"></p>
<p align="center"><a href="https://github.com/NNBnh/clipb.kak/blob/main/LICENSE"><img src="https://img.shields.io/github/license/NNBnh/clipb.kak?labelColor=2E436C&color=F9765A&style=for-the-badge" alt="License: GPL-3.0"></a> <a href="https://gist.github.com/NNBnh/9ef453aba3efce26046e0d3119dab5a7#development-completed"><img src="https://img.shields.io/badge/development-completed-%23F9765A.svg?labelColor=2E436C&style=for-the-badge&logoColor=FFFFFF" alt="Development completed"></a></p>

## 💡 About
`clipb.kak` is a clipboard integration for [Kakoune](http://kakoune.org), an extremely strip down fork of [Zach Peltzer](https://github.com/lePerdu)'s [Kakboard](https://github.com/lePerdu/kakboard) with [some design improvements](#-features).

### 📔 Story
After making [`clipb`](https://github.com/NNBnh/clipb) i revisit [Kakboard](https://github.com/lePerdu/kakboard) and try to improve the plugin by make some pull request. But because i had make a lot of change that might break people existing config, i decided to maintain my own fork of the plugin.

### ✨ Features
- Improve startup speed, took ~20ms less time to startup than [Kakboard](https://github.com/lePerdu/kakboard)
- Support multiple selections copy to clipboard [(enable this feature)](https://github.com/NNBnh/clipb.kak#%EF%B8%8F-configuration)
- Have no plugin keybinding to follow [Steve Losh's blog: "Mapping Keys the Right Way"](https://stevelosh.com/blog/2011/09/writing-vim-plugins/#s6-mapping-keys-the-right-way), instead use register hook to sync clipboard
- Remove unnecessary commands from [Kakboard](https://github.com/lePerdu/kakboard):
  - `pull-if-unset`: this command is pretty handy in the [Kakboard script](https://github.com/lePerdu/kakboard/blob/2f13f5cd99591b76ad5cba230815b80138825120/kakboard.kak#L50-L60) but the end users will not found it really useful and fairly easy to script if need
  - `push-if-unset`: again with this command, the end users will not found it really useful
  - `with-pull-clipboard`: user can simply done this with `clipb-get; exec <key>`
  - `with-push-clipboard`: again, user can simply run `exec <key>; clipb-set`
- More system clipboards supported, supported clipboard managers are:
  - [`wl-clipboard`](https://github.com/bugaevc/wl-clipboard)
  - [`xclip`](https://github.com/astrand/xclip)
  - [`xsel`](http://www.kfish.org/software/xsel)
  - `pbcopy`, `pbpaste`
  - `cygwin`'s `/dev/clipboard`
  - [`termux-api`](https://wiki.termux.com/wiki/Termux:API)

## 🚀 Setup
### 🧾 Dependencies
- [`wl-clipboard`](https://github.com/bugaevc/wl-clipboard) for [Wayland](https://wayland.freedesktop.org)
- [`xclip`](https://github.com/astrand/xclip) or [`xsel`](http://www.kfish.org/software/xsel) for [X.org](https://www.x.org)
- [`termux-api`](https://wiki.termux.com/wiki/Termux:API) for [Termux](https://termux.com)

### 📥 Installation
With [`plug.kak`](https://github.com/robertmeta/plug.kak) just put this in your `kakrc`:
```
plug 'NNBnh/clipb.kak' config %{
	clipb-detect
	clipb-enable
}
```

## ⌨️ Usage
`clipb.kak` come with many commands:
- `clipb-detect`: detect clipboard command on the system to set `clipb_set_command` and `clipb_get_command` options
- `clipb-set`: set system clipboard from the `"` (default) register
- `clipb-get`: get system clipboard into the `"` (default) register
- `clipb-enable`: enable clipb by adding these hooks:
  ```
  hook -group 'clipb' global WinCreate        .* %{ clipb-get }
  hook -group 'clipb' global FocusIn          .* %{ clipb-get }
  hook -group 'clipb' global RegisterModified \" %{ clipb-set }
  ```
- `clipb-disable`: disable clipb by removing `clipb` group hooks

## ⚙️ Configuration
To enable multiple selections copy to clipboard, change the `clipb_multiple_selections` option to `true`:
```
set-option global clipb_multiple_selections 'true'
```

You can change the set or get (copy or paste) command manually:
```
set-option global clipb_set_command '<SET_COMMAND>'
set-option global clipb_get_command '<GET_COMMAND>'
```

or let the plugin detect the clipboard commands on the system:
```
clipb-detect
```

## 💌 Credits
Special thanks to:
- [**Kakboard**](https://github.com/lePerdu/kakboard) by [Zach Peltzer](https://github.com/lePerdu)
- [**Vis-clipboard**](https://github.com/martanne/vis) by [Marc André Tanner](https://github.com/martanne)

<br><br><br><br>

---

> <h1 align="center">Fork with ❤️ by <a href="https://github.com/NNBnh"><i>NNB</i></a></h1>
>
> <p align="center"><a href="https://www.buymeacoffee.com/nnbnh"><img src="https://img.shields.io/badge/buy_me_a_coffee%20-%23F7CA88.svg?logo=buy-me-a-coffee&logoColor=333333&style=for-the-badge" alt="Buy Me a Coffee"></a></p>
