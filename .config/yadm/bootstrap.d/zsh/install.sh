#!/usr/bin/env bash

if [ -d ~/.oh-my-zsh ]; then
  echo "oh-my-zsh folder found, skip installing"
  return
fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
