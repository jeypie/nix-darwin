# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A personal nix-darwin configuration for an Apple Silicon Mac (aarch64-darwin), managing macOS system settings, Homebrew packages, and user environment declaratively via Nix Flakes. Owner: Jan Hoepfner (`jan.hoepfner`), hostname: `jpBook`.

## Build & Apply Commands

```bash
# Rebuild and apply system configuration
darwin-rebuild switch --flake ~/Packages/nix-darwin

# Update all flake inputs (nixpkgs, home-manager, etc.)
nix flake update

# Format all Nix files
find . -type f -name "*.nix" | xargs nixfmt

# Garbage collect old Nix store entries
nix-store --gc
```

## Architecture

The configuration is split into system-level (nix-darwin) and user-level (home-manager) concerns:

```
flake.nix          → Entry point: defines inputs (nixpkgs, nix-darwin, home-manager,
                     nix-homebrew, nixvim) and wires them into a single darwinConfiguration
  ├─ darwin.nix    → System config: macOS defaults, Homebrew brews/casks, networking,
  │                  dock layout, Touch ID sudo, environment variables
  ├─ home.nix      → User config: zsh (powerlevel10k, oh-my-zsh, aliases, fzf),
  │                  git, direnv, fonts; imports all modules below
  ├─ modules/
  │   ├─ nvim.nix      → NixVim config (catppuccin, lualine, treesitter)
  │   └─ packages.nix  → Nix home packages (fzf, zsh plugins, nerd-fonts, nix tools)
  └─ home/
      ├─ files.nix     → Generated dotfiles (kubeconfig refresh script)
      ├─ library.nix   → Personal command reference (~700 lines), browsable via Alt+l
      └─ zsh-p10k.zsh  → Powerlevel10k prompt theme (generated, don't hand-edit)
```

**Key pattern**: Homebrew is the primary package manager for all CLI tools and GUI apps. Nix home-manager packages are only used for zsh plugins, fonts, and Nix development tooling. Terminal: Ghostty (Homebrew cask, pinned to Dock).

## Pre-commit Hooks

Configured via `.pre-commit-config.yaml`:
- File validation (YAML, JSON, TOML, XML), trailing whitespace, merge conflict detection
- AWS credentials and private key detection
- **Commit message format** (gitlint): `(feat|fix|try|maintain)!?(\\(.*\\))?:` with max 80-char title
