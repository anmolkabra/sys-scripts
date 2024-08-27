#!/usr/bin/env bash

# contains functions that start tmux sessions:
# --- website

function website {
    # function to start a tmux session for my website dev environment
    if (tmux has-session -t website 2> /dev/null); then
        tmux attach -t website
    else
        # https://github.com/anmolkabra/anmolkabra.github.io
        # change to website dir on the machine
        WEBSITE_REPO_DIR=$1
        if [ ! -d $WEBSITE_REPO_DIR ]; then
            echo -n "Path $WEBSITE_REPO_DIR doesn't exist, "
            echo "enter the correct path to the directory"
            exit
        fi

        if [ ! -f $WEBSITE_REPO_DIR/Gemfile ]; then
            echo -n "Directory $WEBSITE_REPO_DIR doesn't have a Gemfile, "
            echo "the directory isn't a github-pages repo"
            exit
        fi
        cd $WEBSITE_REPO_DIR

        tmux start-server
        tmux new-session -d -s website -n files
        tmux new-window -t website:1 -n write
        tmux new-window -t website:2 -n vhost
        tmux new-window -t website:3 -n jekyll
        tmux new-window -t website:4 -n git

        # files window
        tmux send-keys -t website:0 "ls -al" C-m

        # write window
        tmux split-window -h -p 50 -t website:1
        tmux send-keys -t website:1 "cd ./_out && ls -al" C-m
        tmux select-pane -t website:1.0

        # vhost window
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
    fi
} # end function website

"$@"
