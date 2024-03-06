#!/bin/bash

current_dir=$(pwd)

merge_zsh_config(){
  echo "Copying contents of .zshrc $current_dir/.zshrc" $HOME/.zshrc
  if [[ -n "$CODESPACES" && -e "$HOME/.zshrc" ]]; then
    cat "$current_dir/.zshrc" >> "$HOME/.zshrc"
  fi
}

merge_zsh_config