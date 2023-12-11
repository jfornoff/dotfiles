#!/bin/sh

if ! [ -x "$(command -v rcup)" ]; then
  echo 'Error: rcm is not installed.' >&2
  exit 1
fi

# Not super neat, you need to be in the directory and run ./install.sh
SYMLINK_DIRS="config conf.rc spacemacs.d secrets vim" rcup -f -vv -d $(pwd)
