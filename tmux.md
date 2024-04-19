# Synchronize/mirror panes
Toggle with `^B:setw synchronize-panes`

# Boilerplate config
````bash
# ~/.tmux.conf
set -g default-terminal "screen-256color"
set -as terminal-overrides ',*:indn@'
set -g mouse
# Display messages for more than 750ms
set-option -g display-time 1500

# reload config on r
bind-key r source-file ~/.tmux.conf \; display-message "Config reloaded"
bind-key ^R source-file ~/.tmux.conf \; display-message "Config reloaded"

# d is bound as default, bind ^D as well
bind-key ^D detach-client

# Detach other clients
bind i detach-client -a -P
bind ^I detach-client -a -P

# rebind c so that we open in PWD, also bind ^C
bind c new-window -c "#{pane_current_path}"
bind ^C new-window -c "#{pane_current_path}"

# Renumber windows when closing
# 0 1 2 3 4 -> close 2 -> 0 1 2 3
set-option -g renumber-windows on

unbind '"'
unbind %
bind '%' split-window -h -c "#{pane_current_path}"
bind '"' split-window -v -c "#{pane_current_path}"
````
