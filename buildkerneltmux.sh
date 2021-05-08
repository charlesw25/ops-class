#!/usr/bin/env bash
ROOTDIR="$HOME/os161/root" # Add your root dir here (where your sys.conf is)
KERNDIR="$HOME/os161/kern" # Add location of your kern directiory in ospath 
VERSION="DUMBVM"   # Variable for future when this might change
DEBUG=false		   # For gdb, set to true if want to make this default
PANE=false		   # For gdb, set to true if want to make this default

while [[ -n "$1" ]]; do	   # Just option stuff, thanks stackoverflow :)
	case "$1" in
	-d) DEBUG=true;;
	-p) PANE=true;;
	-r) 
		ROOTDIR="$2"
		shift
		;;
	-o) 
		KERNDIR="$2"
		shift
		;;
	-v) 
		VERSION="$2"
		shift
		;;
	-h)
		echo "-d: run sys161 and wait for gdb"
		echo "-p: Run tmx windows as one window with 2 panes"
		echo "-r <directory>: Specify root directory"
		echo "-o <directory>: Specify directory for os161 kernels location"
		echo "-v <kernel>: Kernel from kern/compile/ to choose"
		exit
		;;
	esac
	shift
done

# Just the usual workflow from ASST0
tmux has-session -t os161 2>/dev/null

if [ $? = 0 ]; then
	tmux kill-session -t 'os161'
fi

tmux new-session -s 'os161' -d
tmux rename-window -t 0 'sys161'
tmux send-keys -t 'sys161' "cd $KERNDIR/compile/$VERSION" C-m 'bmake' C-m "bmake install" C-m "cd $ROOTDIR" C-m

if $DEBUG; then
	tmux send-keys -t 'sys161' "sys161 -w kernel" C-m
	tmux new-window -t 'os161:1' -n 'gdb'
	tmux send-keys -t 'gdb' "cd $ROOTDIR" C-m "os161-gdb kernel" C-m "target remote unix:.sockets/gdb" C-m
	if $PANE; then
		tmux join-pane -s 'sys161' -t 'gdb'
	fi
else
	tmux send-keys -t 'sys161' "sys161 kernel" C-m
fi
tmux attach-session -t 'os161'
# alias <new name>='/home/<full path to script>/filename.sh' 
# add to ~/.bashrc for making a command. Thanks stackoverflow :)
