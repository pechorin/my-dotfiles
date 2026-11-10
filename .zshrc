# Shared workstation configuration.
export MISE_GLOBAL_CONFIG_FILE="$HOME/my-dotfiles/mise.toml"
export EDITOR=nvim
export GOPATH="$HOME/go"
export ZSH_CACHE_DIR="$HOME/.tmp/zsh"
typeset -U path PATH
path=("$HOME/.local/bin" /opt/homebrew/bin /opt/homebrew/sbin $path)

# Read existing vendor configuration only after deliberate activation.
[[ ! -r "$HOME/yandex-cloud/path.bash.inc" ]] || source "$HOME/yandex-cloud/path.bash.inc"
[[ ! -r "$HOME/yandex-cloud/completion.zsh.inc" ]] || source "$HOME/yandex-cloud/completion.zsh.inc"

# mise manages tools other than Ruby.
if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi

# Ruby uses the existing rbenv installations and project .ruby-version files.
if (( $+commands[rbenv] )); then
  eval "$(rbenv init - --no-rehash zsh)"
fi

fpath=("$HOME/.zsh/completions" $fpath)
autoload -Uz compinit
compinit

if [[ -r /opt/homebrew/opt/antidote/share/antidote/antidote.zsh ]]; then
  source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
  antidote load "$HOME/.zsh_plugins.txt"
fi

alias be='bundle exec'
