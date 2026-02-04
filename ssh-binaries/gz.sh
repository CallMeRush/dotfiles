#!/bin/bash
tmux set -g status-style "bg=$TMUX_GZ,fg=black"
ssh gz
tmux set -g status-style "bg=$TMUX_BASE,fg=black"

