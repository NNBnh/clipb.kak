<h1 align="center"><code>clipb.kak</code></h1>
<p align="center">Clipboard managers warper for Kakoune</p>
<p align="center"><a href="https://github.com/NNBnh/clipb.kak/blob/main/LICENSE"><img src="https://img.shields.io/github/license/NNBnh/clipb.kak?labelColor=585858&color=F7CA88&style=for-the-badge" alt="License: GPL-3.0"></a> <img src="https://img.shields.io/badge/development-completed-%23F7CA88.svg?labelColor=585858&style=for-the-badge&logoColor=FFFFFF" alt="Development completed"></p>
<p align="center"><a href="https://github.com/NNBnh/clipb.kak/watchers"><img src="https://img.shields.io/github/watchers/NNBnh/clipb.kak?labelColor=585858&color=F7CA88&style=flat-square"></a> <a href="https://github.com/NNBnh/clipb.kak/stargazers"><img src="https://img.shields.io/github/stars/NNBnh/clipb.kak?labelColor=585858&color=F7CA88&style=flat-square"></a> <a href="https://github.com/NNBnh/clipb.kak/network/members"><img src="https://img.shields.io/github/forks/NNBnh/clipb.kak?labelColor=585858&color=F7CA88&style=flat-square"></a> <a href="https://github.com/NNBnh/clipb.kak/issues"><img src="https://img.shields.io/github/issues/NNBnh/clipb.kak?labelColor=585858&color=F7CA88&style=flat-square"></a></p>

## 💡 About
`clipb.kak` is a clipboard integration for [Kakoune](http://kakoune.org), an extremely strip down fork of [Kakboard](https://github.com/lePerdu/kakboard) with [some improvements and more clipboard managers supported](#-features).

### 📔 Story
`#TODO`

### ✨ Features
`#TODO`

## 🚀 Setup
### 🧾 Dependencies
- [`wl-clipboard`](https://github.com/bugaevc/wl-clipboard) for [Wayland](https://wayland.freedesktop.org)
- [`xclip`](https://github.com/astrand/xclip) or [`xsel`](http://www.kfish.org/software/xsel) for [X.org](https://www.x.org)
- [`termux-api`](https://wiki.termux.com/wiki/Termux:API) for [Termux](https://termux.com/)

### 📥 Installation
With [`plug.kak`](https://github.com/robertmeta/plug.kak) just put this in your `kakrc`:

```
plug 'NNBnh/clipb.kak' config %{
	clipb-enable
}
```

## ⌨️ Usage
`clipb.kak` come with many commands:
- `clipb-detect`: detect clipboard command
- `clipb-set`: set system clipboard from the `"` (default) register
- `clipb-get`: get system clipboard into the `"` (default) register
- `clipb-enable`: enable clipb by adding these hooks:
  ```
  hook -group 'clipb' global WinCreate        .* %{ clipb-get }
  hook -group 'clipb' global FocusIn          .* %{ clipb-get }
  hook -group 'clipb' global RegisterModified \" %{ clipb-set }
  ```
- `clipb-disable`: disable clipb by removing `clipb` hooks

## ⚙️ Configuration
`#TODO`

```
set-option global clipb_set_command '<SET_COMMAND>'
set-option global clipb_get_command '<GET_COMMAND>'
```

## 💌 Credits
Special thanks to:
- [**Kakboard**](https://github.com/lePerdu/kakboard) by [Zach Peltzer](https://github.com/lePerdu)
- [**Vis-clipboard**](https://github.com/martanne/vis) by [Marc André Tanner](https://github.com/martanne)

<br><br><br><br>

---

> <h1 align="center">Made with ❤️ by <a href="https://github.com/NNBnh"><i>NNB</i></a></h1>
>
> <p align="center"><a href="https://www.buymeacoffee.com/nnbnh"><img src="https://img.shields.io/badge/buy_me_a_coffee%20-%23F7CA88.svg?logo=buy-me-a-coffee&logoColor=333333&style=for-the-badge" alt="Buy Me a Coffee"></p>
