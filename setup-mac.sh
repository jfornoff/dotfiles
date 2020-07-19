#!/bin/sh

echo "-- Writing system settings.."
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 2

echo "-- Setting up brew taps.."
brew tap thoughtbot/formulae
brew tap homebrew/cask-fonts
echo "-- Installing essential utilities.."
ESSENTIAL_UTILS="rcm fzf neovim tmux zsh ripgrep tree reattach-to-user-namespace fasd"
echo "$ESSENTIAL_UTILS" | xargs brew install

echo "-- Installing essential applications.."
ESSENTIAL_APPS="alfred dash docker evernote flux font-fira-code iterm2 spectacle spotify arq"
echo "$ESSENTIAL_APPS" | xargs brew cask install
