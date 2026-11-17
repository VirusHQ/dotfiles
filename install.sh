#!/usr/bin/env bash
# Install Homebrew packages and symlink configs into place.
# Safe to re-run: existing files are moved to *.bak-<timestamp> before linking.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d%H%M%S)"

if [[ "${1:-}" != "--no-brew" ]]; then
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Install it from https://brew.sh then re-run." >&2
    exit 1
  fi
  brew bundle --file="$DOTFILES/Brewfile"
fi

link() {
  local src="$DOTFILES/$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    echo "ok      $dst"
    return
  fi
  if [[ -e "$dst" || -L "$dst" ]]; then
    mv "$dst" "$dst.bak-$STAMP"
    echo "backup  $dst -> $dst.bak-$STAMP"
  fi
  ln -s "$src" "$dst"
  echo "linked  $dst -> $src"
}

link wezterm/wezterm.lua "$HOME/.config/wezterm/wezterm.lua"
link tmux/tmux.conf      "$HOME/.tmux.conf"
link zsh/zshrc           "$HOME/.zshrc"
link zsh/p10k.zsh        "$HOME/.p10k.zsh"

echo "Done. Open a new WezTerm window (or run: exec zsh)."
