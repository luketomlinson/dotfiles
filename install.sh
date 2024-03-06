#!/bin/bash

merge_zsh_config(){
  echo "Copying contents of .zshrc from $HOME/.zshrc to $script_dir/.zshrc"
  if [[ -n "$CODESPACES" && -e "$HOME/.zshrc" ]]; then
    less "$HOME/.zshrc" >> "$script_dir/.zshrc"
  fi
}

merge_zsh_config