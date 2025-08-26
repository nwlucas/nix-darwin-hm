# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a pure Nix flake configuration repository that manages NixOS and macOS (nix-darwin) systems with Home Manager. It uses flake-utils-plus for host generation, nix-darwin for macOS system management, and Home Manager for user environment configuration.

## Commands

### System Management
```bash
# Apply darwin configuration (macOS)
darwin-rebuild switch --flake .

# Apply nixos configuration (Linux)  
nixos-rebuild switch --flake .

# Build configuration (test without applying)
nix build .#darwinConfigurations.HOSTNAME.system
nix build .#nixosConfigurations.HOSTNAME.config.system.build.toplevel

# Format Nix files
just fmt
treefmt
```

### Development
```bash
# List available just commands
just

# Show flake outputs
nix flake show

# Update flake inputs
nix flake update

# Check flake
nix flake check
```

## Architecture

### Flake Structure
- **flake.nix**: Main flake configuration defining inputs, outputs, and host generation logic
- **hosts/**: Host-specific configurations organized by platform
  - `darwinM/`: Apple Silicon macOS hosts  
  - `darwin/`: Intel macOS hosts
  - `nixos/`: x86_64 Linux hosts
  - `nixos-arm/`: ARM64 Linux hosts
- **system/**: Platform-specific system modules
  - `darwin/`: macOS system configuration (dock, finder, fonts, etc.)
  - `nixos/`: NixOS system configuration (boot, users, hardware)
- **home/**: Home Manager configurations
  - `cli/`: Command line tool configurations (git, starship, bat, etc.)
  - `apps/`: Application configurations (wezterm, 1password)
- **users/**: User configuration schema and data
- **modules/**: Shared Nix modules (profiles, shell, nix settings)

### Key Components
- Uses `flake-utils-plus` (`mkFlake`) for declarative host generation from directory structure  
- Supports both stable (25.05) and unstable nixpkgs channels with stable as default
- Integrates nix-darwin for macOS system management and Home Manager for user configurations
- Includes impermanence module for stateless system support
- Uses `mac-app-util` for better macOS application integration
- Includes overlays for VSCode extensions and Rust toolchain
- Primary user: `nwilliams-lucas`
- Theme: `catppuccin`
- Version: `25.05`

### Host Generation  
The flake uses `mkHosts` function with `flake-utils-plus.mkFlake` to automatically generate host configurations from files in the `hosts/` directory tree. Platform type is determined by directory suffix:
- `darwinM/` → Apple Silicon macOS (aarch64-darwin)
- `darwin/` → Intel macOS (x86_64-darwin)
- `nixos-arm/` → ARM64 Linux (aarch64-linux)  
- `nixos/` → x86_64 Linux (x86_64-linux)

Current hosts available:
- **darwinM**: NWL-MBM2, NWL-STUDIO, NWL-STUDIO-DTLR
- **nixos-arm**: nixos-parallels, rpi-01

### Certificate Management
Custom CA certificates are installed from `files/certs/` including Cloudflare CA for corporate environments.

## Configuration Patterns

### Adding New Hosts
Create `.nix` file in appropriate `hosts/` subdirectory. The filename becomes the hostname.

### Modifying System Settings
- macOS: Edit files in `system/darwin/`
- NixOS: Edit files in `system/nixos/`
- Cross-platform: Edit `system/default.nix`

### User Configuration Changes
- CLI tools: `home/cli/`
- Applications: `home/apps/`
- Shell settings: `home/default.nix`

### Package Management
- System packages: `system/packages.nix` or platform-specific package files
- Homebrew (macOS): `system/darwin/brew.nix`
- Overlays: VSCode extensions and Rust toolchain overlays are configured globally

### Development Tools Integration
- Uses `treefmt-nix` for code formatting
- Includes `nix-index` for faster command lookup
- Supports `just` for task automation
- SSH configuration managed through Home Manager