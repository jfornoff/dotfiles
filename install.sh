#!/bin/sh

if ! [ -x "$(command -v rcup)" ]; then
  echo 'Error: rcm is not installed.' >&2
  exit 1
fi

SYMLINK_DIRS="config conf.rc spacemacs.d secrets vim" rcup
