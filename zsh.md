# Config
````bash
# ~/.zshrc
ZSH_THEME="gentoo"
# https://unix.stackexchange.com/questions/273861/unlimited-history-in-zsh
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
````
