WIN_ID=$(tmux display-message -p "#{window_id}")
PANE_ID=$(tmux list-panes -t "$WIN_ID" -F "#{pane_id}")
CMD_IN_PANE=$(tmux display-message -t "$pane" -p "#{pane_current_command}")

case "$CMD_IN_PANE" in
    bz|bz*) 
        tmux set -g status-style "bg=blue,fg=black"
        ;;
    gz|gz*) 
        tmux set -g status-style "bg=green,fg=black"
        ;;
    *)
        tmux set -g status-style "bg=colour13,fg=black"
        ;;
esac

