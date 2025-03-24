#!/bin/bash

current_dir=$(pwd)

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval "$(/opt/homebrew/bin/brew shellenv)"

brew update
brew upgrade

brew install helm

merge_zsh_config(){
  echo "Copying contents of .zshrc $current_dir/.zshrc" $HOME/.zshrc
  if [[ -n "$CODESPACES" && -e "$HOME/.zshrc" ]]; then
    cat "$current_dir/.zshrc" >> "$HOME/.zshrc"
  fi
}

merge_zsh_config