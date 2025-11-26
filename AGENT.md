# Agent's Guide to the Repository

This document provides a comprehensive guide for AI agents to understand and interact with this repository.

## 2. Core Technologies

* **Nix:** The foundation for package management and system configuration.
* **Nix Flakes:** Used for dependency management and providing reproducible builds.
* **NixOS:** The Linux distribution used on some machines.
* **nix-darwin:** To manage macOS configurations declaratively.
* **home-manager:** To manage user-specific dotfiles, packages, and services.
* **Languages:** The primary language is Nix. There is also some Lua for WezTerm configuration.

## 3. Repository Structure

The repository is organized in a modular way:

* flake.nix: The main entry point of the configuration. It defines all dependencies (inputs) and builds the system and home-manager configurations for each host (outputs).
* hosts/: Contains the host-specific configurations. Each file in a subdirectory of hosts/ corresponds to a specific machine.
  * hosts/darwin/: For Intel-based macOS machines.
  * hosts/darwinM/: For ARM-based (Apple Silicon) macOS machines.
  * hosts/nixos/: For x86_64 NixOS machines.
  * hosts/nixos-arm/: For ARM-based NixOS machines.
* system/: Contains the base system-level configurations.
  * system/nixos/: Base configuration for all NixOS hosts.
  * system/darwin/: Base configuration for all macOS hosts.
  * system/packages.nix: System-wide packages for all OSes.
* home/: Contains user-specific configurations managed by home-manager. This is where you'll find dotfiles, user-specific packages, and services. The configuration is highly modular, with configurations for different applications and tools in the apps/ and cli/ subdirectories.
* modules/: Contains reusable Nix modules that can be imported into other parts of the configuration.
* users/: Defines the users and their general settings.

## 4. Common Tasks

Here are instructions for common tasks you might be asked to perform.

### 4.1. Applying Configurations

1. **Identify the hostname:** To see a list of all available host configurations, run:
    nix flake show
    This will list all outputs, including darwinConfigurations.hostname and nixosConfigurations.hostname.

2. **Apply on NixOS:**
    sudo nixos-rebuild switch --flake .#hostname

3. **Apply on macOS:**
    darwin-rebuild switch --flake .#hostname

### 4.2. Managing Packages

#### Adding a User-Specific Package

To add a package for a user, you should add it to the home-manager configuration. The packages are organized into apps and cli tools.

1. Determine if it's a GUI app or a CLI tool.
2. Create a new Nix file in home/apps/ or home/cli/. For example, to add htop, you would create home/cli/htop.nix.
3. The content of the file should enable the program or add the package to home.packages. For example, for htop:

    **home/cli/htop.nix**

```nix
    { pkgs, ... }:
    {
      home.packages = [ pkgs.htop ];
    }
```

For some packages, there might be a programs option in home-manager, like programs.fzf.enable = true;. Prefer using the programs option when available.
4. Import the new file in home/apps/default.nix or home/cli/default.nix.

**home/cli/default.nix**

```nix
    {
      imports = [
        ./htop.nix
        # ... other imports
      ];
    }
```

#### Adding a System-Wide Package

To add a package that should be available to all users on a system:

1. For all systems (NixOS and macOS): Add the package to environment.systemPackages in system/packages.nix.
2. For macOS only: Add the package to environment.systemPackages in system/darwin/packages.nix.
3. For NixOS only: Add the package to environment.systemPackages in a relevant file under system/nixos/.

Example for system/packages.nix:

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    htop # new package
    # ... other packages
  ];
}

### 4.3. Adding a New Host

1. Create a new file in the appropriate subdirectory of hosts/. For example, hosts/nixos/new-server.nix.
2. The hostname will be derived from the filename.
3. The file should contain the host-specific configuration. The base system configuration is already imported by the flake.nix.

    **hosts/nixos/new-server.nix**

```nix
    {
      # Set the state version for NixOS
      system.stateVersion = "23.11";

      # Add any other host-specific options here
      # For example, networking configuration
      networking.hostName = "new-server";
    }
```

### 4.4. Updating Dependencies

To update all flake inputs (dependencies) to their latest versions, run:

nix flake update

After updating, you need to apply the configuration to your systems for the changes to take effect.

### 5. Linting and Formatting

This project uses treefmt-nix for formatting. To format the entire codebase, run:

nix fmt

This will ensure that all Nix files are consistently formatted.
