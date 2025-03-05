# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/vscode/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git kubectl)

ZSH_DISABLE_COMPFIX=true

source $ZSH/oh-my-zsh.sh

# User configuration

jwt-decode() {
  jq -R 'split(".") |.[0:2] | map(@base64d) | map(fromjson)' <<< $1
}

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias gs="git status"
alias c="clear"
alias ra="cd /workspaces/actions/actions-runner-admin"
alias ww="cd /workspaces/actions/actions-broker-worker"
alias ll="cd /workspaces/actions/actions-broker-listener"
alias dd="cd /workspaces/actions/actions-dotnet/src"
alias rl="kubectl rollout restart -n actions-broker-listener deployment/listener" # reload listener
alias luke="echo Your dotfiles are working"
alias cgh="git gc --prune=now"
alias goproxyfix='echo "machine goproxy.githubapp.com login nobody password $GITHUB_TOKEN" >"$HOME/.netrc"'

git config --global push.autoSetupRemote true

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

decode_base64() {
    local encoded_value=$1
    echo "$encoded_value" | base64 --decode | jq .
}

decode_jit() {

    # Input JSON file
    input="$1"

    # echo "input: $input"

    input_json=$(decode_base64 "$input")

    # echo "input_json: $input_json"

    # Extract and decode the .runner value
    runner_base64=$(echo "$input_json" | jq -r '.".runner"')
    runner_decoded=$(decode_base64 "$runner_base64")

    # echo "runner_decoded: $runner_decoded"

    # Extract and decode the .credentials value
    credentials_base64=$(echo "$input_json" | jq -r '.".credentials"')
    credentials_decoded=$(decode_base64 "$credentials_base64")

    # echo "credentials_decoded: $credentials_decoded"

    # Extract and decode the .credentials_rsaparams value
    credentials_rsaparams_base64=$(echo "$input_json" | jq -r '.".credentials_rsaparams"')
    credentials_rsaparams_decoded=$(decode_base64 "$credentials_rsaparams_base64")

    # echo "credentials_rsaparams_decoded: $credentials_rsaparams_decoded"

    # Create the output JSON
    output_json=$(jq -n \
        --argjson runner "$runner_decoded" \
        --argjson credentials "$credentials_decoded" \
        --argjson credentials_rsaparams "$credentials_rsaparams_decoded" \
        '{
            ".runner": $runner,
            ".credentials": $credentials,
            ".credentials_rsaparams": $credentials_rsaparams
        }')

    # Print the output JSON
    echo "$output_json" | jq .
}

jwt-decode() {
  jq -R 'split(".") |.[0:2] | map(@base64d) | map(fromjson)' <<< $1
}