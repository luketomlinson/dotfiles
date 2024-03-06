#!/bin/bash

current_dir=$(pwd)

merge_zsh_config(){
  echo "Copying contents of .zshrc from $HOME/.zshrc to $script_dir/.zshrc"
  if [[ -n "$CODESPACES" && -e "$HOME/.zshrc" ]]; then
    less "$HOME/.zshrc" >> "$current_dir/.zshrc"
  fi
}

merge_zsh_config