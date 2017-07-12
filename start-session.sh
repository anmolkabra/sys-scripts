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
    tmux new-window -t website:1 -n write
    tmux new-window -t website:2 -n vhost
    tmux new-window -t website:3 -n jekyll
    tmux new-window -t website:4 -n git

    # files window
    tmux send-keys -t website:0 "l" C-m

    # write window
    tmux send-keys -t website:1 "l" C-m
    tmux split-window -h -p 50 -t website:1
    tmux send-keys -t website:1 "cd ./_posts && l" C-m
    tmux select-pane -t website:1.0

    # vhost window
    tmux send-keys -t website:2 "cd /etc/apache2" C-m
    tmux split-window -h -p 30 -t website:2
    tmux send-keys -t website:2 "sudo service apache2 restart" C-m
    tmux select-pane -t website:2.0

    # jekyll window
    tmux send-keys -t website:3 "bundle update" C-m
    tmux send-keys -t website:3 "bundle install" C-m
    tmux send-keys -t website:3 "bundle exec jekyll serve --watch" C-m

    # git window
    tmux send-keys -t website:4 "git status" C-m

    tmux select-window -t website:0
    tmux -2 attach-session -t website
} # end function website

"$@"
