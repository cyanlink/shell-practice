#!/bin/sh
#
# name     : Yet Another Windows 3.1
# author   : Inkblot Art Academy (dimpurr, volgorabgle, cyanlink)
# license  : MIT
#

# --- init ---

cmd=$(which tmux)      # tmux path
session=$(hostname -s) # session name
basepath=$(cd `dirname $0`; pwd)

# check tmux install

if [ -z $cmd ]; then
	echo "You need to install tmux."
	exit 1
fi

# set conf

echo "Symlinking _tmux.conf to $HOME/.tmux.conf"
ln -sf $basepath/_tmux.conf $HOME/.tmux.conf

# --- run ---

$cmd has -t $session 2> /dev/null

if [ $? != 0 ]; then
	$cmd new -d -n vim -s $session "vim"
	# $cmd splitw -v -p 20 -t $session "pry" # debug
	# $cmd neww -n cmus -t $session "cmus"
	$cmd neww -n zsh -t $session "zsh"
	$cmd splitw -h -p 50 -t $session "vim"
	$cmd splitw -h -p 50 -t $session "~/Workflow/00Unix/screenfetch"
	$cmd splitw -h -p 50 -t $session "ps -aux"
	$cmd selectw -t $session:5
fi

$cmd att -t $session

exit 0