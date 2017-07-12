#!/usr/bin/env bash

# contains functions that start tmux sessions:
# --- website

function website {
    # function to start a tmux session for my website dev environment

    # https://github.com/anmolkabra/gh_website
    BASE="/home/anmolkabra/Desktop/gh_website"
    cd $BASE

    tmux start-server
    tmux new-session -d -s website -n files
    tmux new-window -t website:1 -n vhost
    tmux new-window -t website:2 -n jekyll
    tmux new-window -t website:3 -n git

    # files window
    tmux send-keys -t website:0 "l" 'C-m'

    # vhost window
    tmux send-keys -t website:1 "cd /etc/apache2" C-m
    tmux split-window -h -p 30 -t website:vhost
    tmux send-keys -t website:1 "sudo service apache2 restart" C-m
    tmux select-pane -t website:1.0

    # jekyll window
    tmux send-keys -t website:2 "bundle update" C-m
    tmux send-keys -t website:2 "bundle install" C-m
    tmux send-keys -t website:2 "bundle exec jekyll serve --watch" C-m

    # git window
    tmux send-keys -t website:3 "git status" C-m

    tmux select-window -t website:0
    tmux -2 attach-session -t website
} # end function website

"$@"
