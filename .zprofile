# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/vorobey/.docker/bin"
# End of Docker Desktop section.

# Shared workstation configuration.
export MISE_GLOBAL_CONFIG_FILE="$HOME/my-dotfiles/mise.toml"
export HOST=localhost
export EDITOR=nvim
export GOPATH="$HOME/go"
export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"
export ZSH_CACHE_DIR="$HOME/.tmp/zsh"

typeset -U path PATH
path=("$HOME/.local/bin" /opt/homebrew/bin /opt/homebrew/sbin $path)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Keep credentials outside the assembled configuration.
# These files are read only when this profile is explicitly put into service.
[[ ! -r "$HOME/.secrets/github_token" ]] || export BUNDLE_GITHUB__COM="$(<"$HOME/.secrets/github_token")"
[[ ! -r "$HOME/.secrets/minimax" ]] || export MCODE_PROVIDER_API_KEY="$(<"$HOME/.secrets/minimax")"
[[ ! -r "$HOME/.secrets/forgejo_token" ]] || export FORGEJO_TOKEN="$(<"$HOME/.secrets/forgejo_token")"

# Shims for non-interactive login shells. Interactive shells activate in .zshrc.
path=("${RBENV_ROOT:-$HOME/.rbenv}/shims" "$PYENV_ROOT/shims" "${MISE_DATA_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/mise}/shims" $path)
