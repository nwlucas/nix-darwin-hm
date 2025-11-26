# AI Assistant Guide

> **Note:** This file is also accessible as `CLAUDE.md` (symlink) for compatibility with Claude Code.

This provides guidance to AI assistants when working with this nix-darwin + Home Manager flake configuration.

## Quick Reference

**Primary user:** `nwilliams-lucas` | **Version:** `25.05` | **Theme:** `catppuccin`

### Essential Commands

```bash
# Apply configuration
darwin-rebuild switch --flake .        # macOS
nixos-rebuild switch --flake .         # NixOS

# macOS maintenance
nix-darwin-reinit [flake-path]         # Fix nix-darwin after macOS upgrades

# Development
nix flake show                         # List all outputs
nix flake update                       # Update dependencies
nix fmt                                # Format all Nix files
just                                   # List available tasks
```

### Directory Structure

```bash
├── flake.nix              # Main flake entry point
├── hosts/                 # Host configurations (filename = hostname)
│   ├── darwinM/          # Apple Silicon macOS (aarch64-darwin)
│   ├── darwin/           # Intel macOS (x86_64-darwin)
│   ├── nixos/            # x86_64 Linux
│   └── nixos-arm/        # ARM64 Linux
├── system/               # System-level configs
│   ├── darwin/          # macOS: dock, finder, fonts, brew
│   └── nixos/           # NixOS: boot, users, hardware
├── home/                # Home Manager user configs
│   ├── cli/             # CLI tools: git, starship, bat, etc.
│   └── apps/            # Applications: wezterm, 1password
├── modules/             # Shared Nix modules
└── users/               # User configuration schema
```

## Common Tasks

### Adding Packages

**User-level (preferred):**

1. Create `home/cli/newtool.nix` or `home/apps/newapp.nix`
2. Add `imports = [ ./newtool.nix ];` to respective `default.nix`
3. Use `programs.newtool.enable = true;` when available, otherwise `home.packages = [ pkgs.newtool ];`

**System-level:**

- All platforms: `system/packages.nix`
- macOS only: `system/darwin/packages.nix`
- NixOS only: Relevant file under `system/nixos/`

### Adding Hosts

Create `hosts/<platform>/<hostname>.nix`. Platform suffix determines architecture. The filename becomes the hostname.

### Modifying Settings

- **macOS:** `system/darwin/`
- **NixOS:** `system/nixos/`
- **Cross-platform:** `system/default.nix`
- **User environment:** `home/`

## Architecture Details

For in-depth architecture documentation, see [ARCHITECTURE.md](ARCHITECTURE.md).

**Key technical points:**

- Uses `flake-utils-plus.mkFlake` for declarative host generation
- Supports stable (25.05) and unstable nixpkgs channels
- Includes overlays for VSCode extensions and Rust toolchain
- Custom CA certificates from `files/certs/` for corporate environments
- PATH includes `~/.local/bin` for custom scripts (via Home Manager)

**Current hosts:**

- **darwinM:** NWL-MBM2, NWL-STUDIO, NWL-STUDIO-DTLR
- **nixos-arm:** nixos-parallels, rpi-01

## Notes for AI Assistants

- Always format Nix code with `nix fmt` after changes
- Always address markdown lint issues
- Prefer editing existing files over creating new ones
- Test configurations with `nix build .#<configuration>` before applying
- Use relative paths from repo root when referencing files
- Check `just` commands for project-specific tasks
