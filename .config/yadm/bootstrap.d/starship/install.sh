#!/bin/sh
if command -v starship 2>&1 > /dev/null; then
  return
fi
curl -sS https://starship.rs/install.sh | sh
