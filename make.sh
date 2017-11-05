#!/bin/bash

##############################################
# Creates symlinks from dotfiles in ~/dotfiles
# to their expected location
##############################################

### Vars

dir=~/dotfiles
olddir=~/dotfiles_old/
files="zshrc vimrc vim tmux.conf conf.rc spacemacs secrets gitignore"

### Create backup folder for old dotfiles
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "Done!"

### Change to dotfiles dir
echo "Changing to $dir"
cd $dir
echo "Done!"

# move existing dotfiles to olddir, then symlink from dotfiles directory
for file in $files; do
	echo "Moving any existing dotfiles from ~ to $olddir"
	mv ~/.$file $olddir
	echo "Symlinking!"
	ln -s $dir/$file ~/.$file
done
echo "All done!"
