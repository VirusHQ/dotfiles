#!/usr/bin/env bash
# One-command setup for a new Mac:
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/VirusHQ/dotfiles/main/bootstrap.sh)"
set -euo pipefail

REPO="https://github.com/VirusHQ/dotfiles.git"
DEST="${DOTFILES_DIR:-$HOME/dotfiles}"

# 1. Homebrew (also installs Xcode Command Line Tools, which provides git)
if ! command -v brew >/dev/null 2>&1; then
  for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [[ -x "$b" ]] && eval "$("$b" shellenv)" && break
  done
fi
if ! command -v brew >/dev/null 2>&1; then
  echo "==> Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [[ -x "$b" ]] && eval "$("$b" shellenv)" && break
  done
fi

# Make brew available in future login shells (zshrc in this repo doesn't do it)
if ! grep -qs 'brew shellenv' "$HOME/.zprofile"; then
  echo "eval \"\$($(command -v brew) shellenv)\"" >> "$HOME/.zprofile"
fi

# 2. Clone or update the repo
if [[ -d "$DEST/.git" ]]; then
  echo "==> Updating $DEST"
  git -C "$DEST" pull --ff-only
else
  echo "==> Cloning into $DEST"
  git clone "$REPO" "$DEST"
fi

# 3. Packages + symlinks
"$DEST/install.sh"

echo "==> All set. Open WezTerm."
