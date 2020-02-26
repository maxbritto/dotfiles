#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~;

	if [ -n "$ZSH_VERSION" ]; then
   		# assume Zsh
   		source ~/.zshrc;
	elif [ -n "$BASH_VERSION" ]; then
   		# assume Bash
   		source ~/.bash_profile;
	else
   		# assume something else
		echo "Unknown shell environment"
	fi
}



if [ -n "$ZSH_VERSION" ]; then
   	read "?This may overwrite existing files in your home directory. Are you sure? (y/n) ";
elif [ -n "$BASH_VERSION" ]; then
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
fi

echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	doIt;
fi;
unset doIt;
