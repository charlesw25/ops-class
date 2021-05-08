#!/usr/bin/env bash
ROOTDIR="$HOME/os161/root" # Add your root dir here (where your sys.conf is)
KERNDIR="$HOME/os161/kern" # Add location of your kern directiory in ospath 
VERSION="DUMBVM"   # Variable for future when this might change
DEBUG=false		   # For gdb, set to true if want to make this default
while [[ -n "$1" ]]; do	   # Just option stuff, thanks stackoverflow :)
	case "$1" in
	-d) DEBUG=true;;
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
		echo "-r <directory>: Specify root directory"
		echo "-o <directory>: Specify directory for os161 kernels location"
		echo "-v <kernel>: Kernel from kern/compile/ to choose"
		exit
		;;
	esac
	shift
done

# Just the usual workflow from ASST0
cd $KERNDIR/compile/$VERSION
bmake
bmake install
cd $ROOTDIR
if $DEBUG; then
	sys161 -w kernel
else
	sys161 kernel
fi
# alias <new name>='/home/<full path to script>/filename.sh' 
# add to ~/.bashrc for making a command. Thanks stackoverflow :)
