# nix-darwin

Declarative macOS system configuration for **jpBook** (Apple Silicon) using [nix-darwin](https://github.com/LnL7/nix-darwin), [home-manager](https://github.com/nix-community/home-manager), and [nix-homebrew](https://github.com/zhaofengli-wip/nix-homebrew).

## Prerequisites

- [Nix](https://nixos.org/download/) with flakes enabled
- [Homebrew](https://brew.sh/) (managed declaratively via nix-homebrew)
- Rosetta 2 for Apple Silicon: `softwareupdate --install-rosetta`

## Initial Setup

```bash
nix run nix-darwin -- switch --flake ~/Packages/nix-darwin
```

## Daily Usage

```bash
# Rebuild and apply configuration changes
darwin-rebuild switch --flake ~/Packages/nix-darwin

# Update all flake inputs (nixpkgs, home-manager, nix-darwin, etc.)
nix flake update

# Garbage collect unused Nix store entries
nix-store --gc

# Format all Nix files
find . -type f -name "*.nix" | xargs nixfmt
```

## Architecture

```
flake.nix               # Entry point — inputs, outputs, module wiring
├── darwin.nix          # macOS system: Homebrew brews/casks/taps, dock, Finder,
│                       #   networking, Touch ID sudo, environment variables
├── home.nix            # User environment: zsh (powerlevel10k, oh-my-zsh, fzf),
│                       #   git, direnv, shell aliases, session variables
├── modules/
│   ├── nvim.nix        # NixVim config (catppuccin, lualine, treesitter)
│   └── packages.nix    # Nix home packages (zsh plugins, fonts, nix dev tools)
└── home/
    ├── files.nix       # Generated dotfiles (kubeconfig refresh script)
    ├── library.nix     # Command reference library (~700 lines, browse with Alt+l)
    └── zsh-p10k.zsh    # Powerlevel10k prompt theme (generated — don't hand-edit)
```

### Package Management Strategy

| What                        | Managed by       | Where                  |
|-----------------------------|------------------|------------------------|
| CLI tools (kubectl, helm…)  | Homebrew brews   | `darwin.nix`           |
| GUI apps (Ghostty, Chrome…) | Homebrew casks   | `darwin.nix`           |
| Zsh plugins, fonts, nix dev | Nix home-manager | `modules/packages.nix` |
| Neovim                      | NixVim           | `modules/nvim.nix`     |

Homebrew is the primary package manager. Nix packages are used only for shell plugins, fonts, and Nix development tooling that integrates better through home-manager.

## How to Add Packages

**Homebrew CLI tool** — add to `brews` list in `darwin.nix`:
```nix
brews = [
  "new-tool"
  # ...
];
```

**GUI application** — add to `casks` list in `darwin.nix`:
```nix
casks = [
  "new-app"
  # ...
];
```

**Mac App Store app** — add to `masApps` in `darwin.nix`:
```nix
masApps = {
  "App Name" = 123456789; # App Store ID
};
```

Then rebuild: `darwin-rebuild switch --flake ~/Packages/nix-darwin`

## How to Customize

### Dock Apps
Edit `system.defaults.dock.persistent-apps` in `darwin.nix`. Use `/Applications/Name.app` paths.

### macOS Defaults
Add settings under `system.defaults` in `darwin.nix` (Finder, Dock, login window, etc.).

### Shell Aliases
Add to `programs.zsh.shellAliases` in `home.nix`.

### Environment Variables
Add to `programs.zsh.sessionVariables` in `home.nix` or `environment.variables` in `darwin.nix` (system-wide).

## Terminal

This setup uses [Ghostty](https://ghostty.org/) as the primary terminal emulator (installed via Homebrew cask, pinned to the Dock).

## Key Features

- **Touch ID sudo** — authenticate `sudo` with fingerprint
- **Kubeconfig aggregation** — auto-merges all configs in `~/.kube/configs/` on shell startup
- **Command library** — press `Alt+l` for an interactive fzf-powered command reference
- **Powerlevel10k** — fast zsh prompt with git, kubernetes, terraform context
- **Direnv + nix-direnv** — per-project environments that load automatically
