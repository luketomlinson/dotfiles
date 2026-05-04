# If this is an interactive shell and zsh exists, replace bash with zsh
if [ -z "$ZSH_VERSION" ] && [ -t 1 ] && command -v zsh >/dev/null; then
  exec zsh -l
fi