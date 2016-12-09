cd ~/Projects/savannah
# start session with one window
tmux new -n "api" -s "savannah" -d

# create other require windows
tmux new-window -t "savannah" -n "frontend"
tmux new-window -t "savannah" -n "wot"
tmux new-window -t "savannah" -n "valueset-server"

# partition the windows as required
tmux split-window -v -t "savannah:api"
tmux split-window -v -t "savannah:frontend"
tmux split-window -v -t "savannah:wot"
tmux split-window -v -t "savannah:valueset-server"

# commands to run on specific windows and panes
tmux send-keys -t savannah:api.1 'cd emr-backend && workon emr && source env.sh && ./manage.py runserver' C-m
tmux send-keys -t savannah:api.2 'cd emr-backend && workon emr && source env.sh' C-m


tmux send-keys -t savannah:frontend.1 'cd emr-frontend && grunt connect' C-m
tmux send-keys -t savannah:frontend.2 'cd emr-frontend && grunt build' C-m


tmux send-keys -t savannah:wot.1 'cd slade360-wot/sil_auth_server && source env.sh && workon slade360-wot && ./manage.py runserver 9000' C-m
tmux send-keys -t savannah:wot.2 'cd slade360-wot' C-m

tmux send-keys -t savannah:valueset-server.1 'cd slade360-valuesets-server && workon valueset-server && ./manage.py runserver 8050' C-m
tmux send-keys -t savannah:valueset-server.2 'cd slade360-valuesets-server' C-m

# attach the session
tmux attach -t "savannah"
