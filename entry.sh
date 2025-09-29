#!/usr/bin/env bash

# Colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== Starting nix-darwin setup ===${NC}"

CONFIG_DIR="$HOME/nix-darwin-hm"

# Clone the repo if not already cloned
if [ ! -d "$CONFIG_DIR" ]; then
  echo -e "${YELLOW}Cloning nix-darwin repo...${NC}"
  git clone https://github.com/nwlucas/nix-darwin-hm.git "$CONFIG_DIR"
else
  echo -e "${GREEN}✓ nix-darwin repo already cloned${NC}"
fi

if command -v nix &> /dev/null; then
    echo -e "${GREEN}✓ Nix is already installed. Exiting.${NC}"
    exit 0
fi

cd "$CONFIG_DIR" || {
  echo -e "${RED}Failed to enter directory${NC}"
  exit 1
}

# Run your original install.sh script
bash install.sh
