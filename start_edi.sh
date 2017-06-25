cd ~/Projects/savannah
# start session with one window
tmux new -n "edi_api" -s "savannah_edi" -d

# create other require windows
tmux new-window -t "savannah_edi" -n "edi_frontend_payer"
tmux new-window -t "savannah_edi" -n "edi_frontend_provider"
tmux new-window -t "savannah_edi" -n "wot"

# partition the windows as required
tmux split-window -v -t "savannah_edi:edi_frontend_payer"
tmux split-window -v -t "savannah_edi:edi_frontend_provider"
tmux split-window -v -t "savannah_edi:wot"

# commands to run on specific windows and panes
tmux send-keys -t savannah_edi:edi_api.1 'cd /Volumes/PeculiarYak/vagrant/ubuntu/ && vagrant up && vagrant ssh -- -R 9000:localhost:9000' C-m


tmux send-keys -t savannah_edi:edi_frontend_payer.1 'cd sil-provider-portal && source env.sh && npm run start-dev' C-m
tmux send-keys -t savannah_edi:edi_frontend_payer.2 'cd sil-provider-portal && source env.sh && npm run build' C-m

tmux send-keys -t savannah_edi:edi_frontend_provider.1 'cd sil-provider-portal && source env_p.sh && npm run start-dev' C-m
tmux send-keys -t savannah_edi:edi_frontend_provider.2 'cd sil-provider-portal && source env_p.sh && npm run build' C-m


tmux send-keys -t savannah_edi:wot.1 'cd slade360-wot/sil_auth_server && source env.sh && workon slade360-wot && ./manage.py runserver 9000' C-m
tmux send-keys -t savannah_edi:wot.2 'cd slade360-wot' C-m


# attach the session
tmux attach -t "savannah_edi"
