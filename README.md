# dotfiles

My macOS terminal setup: **WezTerm** (Tokyo Night, minimal, fast) + **tmux** (Ctrl-a prefix) + **zsh** with **Powerlevel10k**, fzf, zoxide, eza and lazygit.

## Install on a new Mac

Paste this into Terminal — it installs Homebrew if needed, clones this repo to `~/dotfiles`, installs every package and links the configs:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/VirusHQ/dotfiles/main/bootstrap.sh)"
```

Or manually:

```sh
git clone https://github.com/VirusHQ/dotfiles.git ~/dotfiles
~/dotfiles/install.sh            # brew bundle + symlinks
# ~/dotfiles/install.sh --no-brew   # symlinks only
```

Existing files are backed up as `*.bak-<timestamp>` before being replaced with symlinks, so re-running is safe.

## What's included

| File | Linked to | Notes |
|---|---|---|
| `wezterm/wezterm.lua` | `~/.config/wezterm/wezterm.lua` | JetBrains Mono (bundled with WezTerm), Tokyo Night, no ligatures, tab bar hidden with one tab, Cmd-←/→ line start/end, Cmd-K clear, left Option = Alt |
| `tmux/tmux.conf` | `~/.tmux.conf` | Prefix `Ctrl-a`, `|` / `-` splits, `h/j/k/l` pane moves, vi copy mode, Tokyo Night status bar |
| `zsh/zshrc` | `~/.zshrc` | History, completion, eza aliases, fzf (Ctrl-R/Ctrl-T/Alt-C), zoxide (`z`, `zi`), `lg` = lazygit, `t` = attach tmux session `main` |
| `zsh/p10k.zsh` | `~/.p10k.zsh` | Powerlevel10k prompt (re-run `p10k configure` to change) |
| `Brewfile` | — | Every package the configs depend on |

No WezTerm Lua plugins are used; all "addons" are Homebrew packages listed in the `Brewfile`.

## Updating

Configs are symlinks into this repo, so edit them in place, then:

```sh
cd ~/dotfiles && git add -A && git commit -m "..." && git push
# on other Macs
cd ~/dotfiles && git pull
```
