# nix-darwin

Declarative macOS configuration for **jarvis** — powered by [nix-darwin](https://github.com/LnL7/nix-darwin) + [home-manager](https://github.com/nix-community/home-manager).

## What's in here

| File | Purpose |
|---|---|
| `flake.nix` | Entry point — pins nixpkgs, nix-darwin, home-manager |
| `flake.lock` | Locked inputs for reproducible builds |
| `configuration.nix` | System-level config (macOS defaults, nix settings, users) |
| `home.nix` | User-level config (packages, shell, git, starship, fastfetch) |

## Included

- **Starship** prompt — git info, language versions, nix shell indicator
- **Fastfetch** — macOS Apple logo on terminal start
- **Zsh** — autosuggestions, syntax highlighting, fzf, zoxide
- **Direnv** with nix-direnv integration
- **Dev tools** — helix, lazygit, gh, ripgrep, fd, jq, eza, bat
- **Runtimes** — bun, uv, node 22
- **macOS defaults** — sensible Finder, Dock, and keyboard settings

## Usage

```bash
# Apply config
darwin-rebuild switch --flake ~/.config/nix-darwin#jarvis

# Or from anywhere
darwin-rebuild switch --flake github:ad-world/nix-darwin#jarvis
```

## Bootstrap

If setting up from scratch:

```bash
# 1. Install nix
sh <(curl -L https://nixos.org/nix/install)

# 2. Clone
git clone https://github.com/ad-world/nix-darwin ~/.config/nix-darwin

# 3. Build
nix run nix-darwin -- switch --flake ~/.config/nix-darwin#jarvis
```

## License

MIT
