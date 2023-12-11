#!/bin/sh
# Runs https://www.chezmoi.io/ for this configuration.
# We might have different chezmoi deployments on the same machine
# (e.g., for private & public configs).

if ! [ -x "$(command -v chezmoi)" ]; then
  echo 'Error: chezmoi is not installed.' >&2
  exit 1
fi

chezmoi -S $(dirname "$0") "$@"
