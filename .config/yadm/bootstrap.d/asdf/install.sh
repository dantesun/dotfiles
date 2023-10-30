#!/usr/bin/env bash

if ! [ -d ~/.asdf ]; then
  echo "Installing asdf"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1
fi
