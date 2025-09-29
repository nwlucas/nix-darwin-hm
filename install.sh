#!/usr/bin/env bash
# Colors for better output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Nix and Nix-Darwin Configuration Setup ===${NC}"
echo "This script will install Nix, set up nix-darwin, and configure your personal variables."
echo

# Detect operating system
OS="$(uname -s)"
case "${OS}" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    *)          MACHINE="UNKNOWN:${OS}"
esac

echo -e "${BLUE}Detected OS: ${MACHINE}${NC}"

# Check if Homebrew is already installed
if command -v brew >/dev/null 2>&1; then
  echo -e "${GREEN}✓ Homebrew is already installed${NC}"
else
  echo -e "${YELLOW}Installing Homebrew...${NC}"
  
  case "${MACHINE}" in
    Mac)
      # Install Homebrew for macOS
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      ;;
    Linux)
      # Install Homebrew for Linux
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      
      # Add Homebrew to PATH for Linux (it's typically installed in /home/linuxbrew/.linuxbrew)
      if [ -d "/home/linuxbrew/.linuxbrew" ]; then
        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
      fi
      ;;
    *)
      echo -e "${RED}Unsupported operating system: ${MACHINE}${NC}"
      echo "Homebrew installation may not work correctly."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      ;;
  esac
  
  # Source Homebrew environment to make brew command available in current shell
  echo -e "${YELLOW}Sourcing Homebrew environment...${NC}"
  case "${MACHINE}" in
    Mac)
      # Try common macOS Homebrew locations
      if [ -f "/opt/homebrew/bin/brew" ]; then
        # Apple Silicon Mac
        eval "$(/opt/homebrew/bin/brew shellenv)"
      elif [ -f "/usr/local/bin/brew" ]; then
        # Intel Mac
        eval "$(/usr/local/bin/brew shellenv)"
      elif command -v brew >/dev/null 2>&1; then
        # If brew is somehow already in PATH, use it
        eval "$(brew shellenv)"
      fi
      ;;
    Linux)
      # For Linux, we already sourced it above, but let's ensure it's sourced again
      if [ -d "/home/linuxbrew/.linuxbrew" ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
      elif command -v brew >/dev/null 2>&1; then
        eval "$(brew shellenv)"
      fi
      ;;
  esac
  
  # Verify installation
  if command -v brew >/dev/null 2>&1; then
    echo -e "${GREEN}✓ Homebrew installed successfully${NC}"
  else
    echo -e "${RED}Warning: Homebrew installation may have failed. Please check manually.${NC}"
  fi
fi

# Check if Nix is already installed
if command -v nix >/dev/null 2>&1; then
  echo -e "${GREEN}✓ Nix is already installed${NC}"
else
  echo -e "${YELLOW}Installing Nix...${NC}"
  # Install Nix
  curl -fsSL https://install.determinate.systems/nix | sh -s -- install
  # Source nix profile to make nix commands available in current shell
  if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
  fi
  echo -e "${GREEN}✓ Nix installed successfully${NC}"
fi

# Enable flakes
echo -e "${YELLOW}Enabling Nix flakes...${NC}"
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >~/.config/nix/nix.conf
echo -e "${GREEN}✓ Nix flakes enabled${NC}"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# Get hostname with default
current_hostname=$(hostname)
hostname=${hostname:-$current_hostname}

# Get username with default
current_user=$(whoami)
username=${username:-$current_user}

# Get home directory with smart default
default_home="/Users/${username}"
home_dir=${home_dir:-$default_home}

# Check if nix-darwin is installed
if [ -e "/run/current-system/sw/bin/darwin-rebuild" ]; then
  echo -e "${GREEN}✓ nix-darwin is already installed${NC}"
else
  echo -e "${YELLOW}Installing nix-darwin...${NC}"
  # Create the ~/.config/nix-darwin directory if it doesn't exist
  mkdir -p ~/.config/nix-darwin
  # Install nix-darwin
  nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
  ./result/bin/darwin-installer
  echo -e "${GREEN}✓ nix-darwin installed successfully${NC}"
fi

# Run nix-darwin switch with the flake
echo -e "${YELLOW}Applying nix-darwin configuration...${NC}"
if nix run nix-darwin -- switch --flake ~/nix-darwin-hm; then
  echo -e "${GREEN}✓ nix-darwin configuration applied successfully${NC}"
else
  echo -e "${RED}Failed to apply nix-darwin configuration. Please check for errors.${NC}"
  exit 1
fi

echo
echo -e "${GREEN}Setup complete!${NC}"
