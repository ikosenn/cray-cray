cd ~/Projects/savannah
# start session with one window
tmux new -n "api" -s "savannah" -d

# create other require windows
tmux new-window -t "savannah" -n "frontend"
tmux new-window -t "savannah" -n "wot"

# partition the windows as required
tmux split-window -v -t "savannah:api"
tmux split-window -v -t "savannah:frontend"
tmux split-window -v -t "savannah:wot"

# commands to run on specific windows and panes 
tmux send-keys -t savannah:api.1 'cd emr-backend && workon emr && ./manage.py runserver' C-m
tmux send-keys -t savannah:api.2 'cd emr-backend && workon emr' C-m


tmux send-keys -t savannah:frontend.1 'cd emr-frontend && grunt connect' C-m
tmux send-keys -t savannah:frontend.2 'cd emr-frontend && grunt build' C-m


tmux send-keys -t savannah:wot.1 'cd slade360-wot/sil_auth_server && source ../auth.sh && workon wot && ./manage.py runserver 9000' C-m
tmux send-keys -t savannah:wot.2 'cd slade360-wot/sil_auth_server' C-m

# attach the session
tmux attach -t "savannah"
