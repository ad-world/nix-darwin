# Agent Notes

This repository is a declarative macOS setup using Nix flakes, nix-darwin, Home Manager, and Homebrew integration.

## What this repo manages

- System-level macOS configuration
- Per-user Home Manager configuration
- Host-specific machine configuration
- CLI tools, shells, prompt, editor, terminal, GitHub CLI, and custom packages
- Homebrew taps, brews, and casks for tools that are not managed through Nix

## How to work in this repo

- Prefer declarative Nix changes over imperative setup commands.
- Keep shared settings in common configuration.
- Keep machine-specific settings isolated by host.
- Keep user-level tools and dotfile-style config in Home Manager.
- Use Homebrew only when a package is unavailable or impractical through Nix.
- Avoid hardcoding paths unless they are intentionally user-specific.

## Validation

Before suggesting or committing changes, run:

```bash
nix flake check
```

For local application, use the provided wrapper scripts or:

```bash
darwin-rebuild switch --flake .#<host>
```

## Style

- Keep modules small and focused.
- Add comments when the purpose of a setting is not obvious.
- Prefer stable, readable Nix over clever abstractions.
- When adding packages, group them by purpose.
- When changing host behavior, confirm which machine the change targets.

## Important context

- This config currently targets Apple Silicon macOS.
- The primary user is `aryaman`.
- Homebrew activation may update and clean up packages.
- Some apps are managed as casks because they are GUI or external tooling.
