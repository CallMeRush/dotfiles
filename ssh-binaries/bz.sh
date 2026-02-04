#!/bin/bash
tmux set -g status-style "bg=$TMUX_BZ,fg=black"
ssh bz
tmux set -g status-style "bg=$TMUX_BASE,fg=black"

