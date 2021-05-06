#    _________       ____
#   / ____/ (_)___  / __ )
#  / /   / / / __ \/ __  |
# / /___/ / / /_/ / /_/ /
# \____/_/_/ .___/_____/
#         /_/

# File:             clipb.kak
# Description:      Clipboard managers warper for Kakoune
# Original author:  Zach Peltzer
#                   └─ https://github.com/lePerdu
# Fork maintainer:  NNB
#                   └─ https://github.com/NNBnh
# URL:              https://github.com/NNBnh/clipb.kak
# License:          GPLv3

#    Permission is hereby granted, free of charge, to any person obtaining a copy
#    of this software and associated documentation files (the "Software"), to deal
#    in the Software without restriction, including without limitation the rights
#    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#    copies of the Software, and to permit persons to whom the Software is
#    furnished to do so, subject to the following conditions:
#
#    The above copyright notice and this permission notice shall be included in all
#    copies or substantial portions of the Software.
#
#    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#    SOFTWARE.

# Functions
define-command clipb-detect -docstring 'detect clipboard command' %{
	evaluate-commands %sh{
		case $(uname -s | tr '[:upper:]' '[:lower:]') in
			'cygwin')
				 copy_command='tee /dev/clipboard 2>&-'
				paste_command='cat /dev/clipboard'
			;;
			'darwin'*)
				 copy_command='pbcopy'
				paste_command='pbpaste'
			;;
			*)
				if [ -n "$WAYLAND_DISPLAY" ]; then
					if [ -x "$(command -v wl-copy)" ] && [ -x "$(command -v wl-paste)" ]; then
						 copy_command='wl-copy'
						paste_command='wl-paste --no-newline'
					else
						printf '%s\n%s' "echo -debug \"clipb.kak: can't interact with Wayland's clipboard\"" \
						                "echo -debug \"please install 'wl-clipboard'\""

						exit 1
					fi
				elif [ -n "$DISPLAY" ]; then
					if [ -x "$(command -v xclip)" ]; then
						 copy_command='xclip -in  -selection clipboard'
						paste_command='xclip -out -selection clipboard'
					elif [ -x "$(command -v xsel)" ]; then
						 copy_command='xsel --input  --clipboard'
						paste_command='xsel --output --clipboard'
					else
						printf '%s\n%s' "echo -debug \"clipb.kak: can't interact with Xorg's clipboard\"" \
						                "echo -debug \"please install 'xclip' or 'xsel'\""

						exit 1
					fi
				else
					if [ -x "$(command -v termux-clipboard-set)" ]; then
						 copy_command='termux-clipboard-set'
						paste_command='termux-clipboard-get'
					else
						printf '%s' "echo -debug \"clipb.kak: this system is not supported\""

						exit 1
					fi
				fi
			;;
		esac

		printf '%s\n%s' "set-option global clipb_set_command '$copy_command'" \
		                "set-option global clipb_get_command '$paste_command'"
	}
}

define-command clipb-set -docstring 'set system clipboard from the " register' %{
	nop %sh{
		printf '%s' "$kak_reg_dquote" | eval "$kak_opt_clipb_set_command" >/dev/null 2>&1 &
	}
}

define-command clipb-get -docstring 'get system clipboard into the " register' %{
	evaluate-commands %sh{
		[ "$kak_reg_dquote" != "$(eval "$kak_opt_clipb_get_command")" ] \
		&& printf '%s' 'set-register dquote %sh{ eval "$kak_opt_clipb_get_command" }'
	}
}

define-command clipb-enable -docstring 'enable clipb' %{
	hook -group 'clipb' global WinCreate        .* %{ clipb-get }
	hook -group 'clipb' global FocusIn          .* %{ clipb-get }
	hook -group 'clipb' global RegisterModified \" %{ clipb-set }
}

define-command clipb-disable -docstring 'disable clipb' %{
	remove-hooks global 'clipb'
}


# Values
declare-option -docstring 'command to copy to clipboard'    str clipb_set_command 'clipb copy'
declare-option -docstring 'command to paste from clipboard' str clipb_get_command 'clipb paste'

clipb-detect
