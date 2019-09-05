#!/bin/bash
SESSION="work"

# fixes colors in tmux
export TERM=screen-256color

# start new session
tmux -2 new-session -d -s $SESSION

# split window at bottom 20% good with macbook pro
tmux split-window -v -p 15

# load up top in 75% right of bottom pane
tmux split-window -h -p 15

# I like to use htop
tmux send-keys "nice htop" C-m

# Setup a window for tailing log files
tmux new-window -t $SESSION:1 -n 'logs'

tmux select-window -t $SESSION:0
tmux select-pane -t 0

tmux -2 attach-session -t $SESSION
