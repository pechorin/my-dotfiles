# Prepared configuration; not sourced during migration.
# This file makes the single config global after a deliberate migration.
export MISE_GLOBAL_CONFIG_FILE="$HOME/my-mise/mise.toml"
export HOST=localhost
export EDITOR=nvim
export GOPATH="$HOME/go"
export ZSH_CACHE_DIR="$HOME/.tmp/zsh"

typeset -U path PATH
path=("$HOME/.local/bin" /opt/homebrew/bin /opt/homebrew/sbin $path)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Keep credentials outside the assembled configuration.
# These files are read only when this profile is explicitly put into service.
[[ ! -r "$HOME/home-files/secrets/github_token" ]] || export BUNDLE_GITHUB__COM="$(<"$HOME/home-files/secrets/github_token")"
[[ ! -r "$HOME/home-files/secrets/minimax" ]] || export MCODE_PROVIDER_API_KEY="$(<"$HOME/home-files/secrets/minimax")"
[[ ! -r "$HOME/home-files/secrets/forgejo_token" ]] || export FORGEJO_TOKEN="$(<"$HOME/home-files/secrets/forgejo_token")"

# Shims for non-interactive login shells. Interactive shells activate in .zshrc.
path=("${MISE_DATA_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/mise}/shims" $path)
