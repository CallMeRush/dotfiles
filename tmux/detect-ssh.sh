WIN_ID=$(tmux display-message -p "#{window_id}")
PANE_ID=$(tmux list-panes -t "$WIN_ID" -F "#{pane_id}")
CMD_IN_PANE=$(tmux display-message -t "$pane" -p "#{pane_current_command}")

case "$CMD_IN_PANE" in
    bz|bz*) 
        tmux set -g status-style "bg=$TMUX_BZ,fg=black"
        ;;
    gz|gz*) 
        tmux set -g status-style "bg=$TMUX_GZ,fg=black"
        ;;
    *)
        tmux set -g status-style "bg=$TMUX_BASE,fg=black"
        ;;
esac

