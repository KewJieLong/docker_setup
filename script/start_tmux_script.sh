code_path="/code"
experiment_path="/media/seven/HD_1/Kew"

for i in 1 2 3; do
	tmux new-session -d -s kew_${i} -c ${code_path}
	tmux split-window -t kew_${i}:0 -h 
	tmux send-keys -t kew_${i}:0 'watch -n1 nvidia-smi' Enter
	tmux split-window -t kew_${i}:0 -v -c ${code_path}
	tmux send-keys -t kew_${i}:0 'htop' Enter
	tmux select-pane -t kew_${i}.0
	tmux split-window -t kew_${i}:0 -v -c ${experiment_path}
done

tmux new-session -d -s tfboard -c ${experiment_path}
tmux split-window -t tfboard:0 -h -c ${experiment_path}
tmux split-window -t tfboard:0 -v -c ${experiment_path}
tmux send-keys -t tfboard:0 'htop' Enter
tmux select-pane -t tfboard.0
tmux split-window -t tfboard:0 -v -c ${experiment_path}

tmux a -t kew_1