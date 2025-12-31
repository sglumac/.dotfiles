#!/bin/bash
# 1. Make executable: chmod +x bootstrap.sh
# 2. Run the script:  ./bootstrap.sh

# Check if GNU Stow is installed
if ! command -v stow &> /dev/null; then
    echo "GNU Stow is not installed!"
    echo "Install with: sudo apt update && sudo apt install -y stow"
    exit 1
fi

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Change to the script directory (dotfiles repo root)
cd "$SCRIPT_DIR"

echo "Setting up dotfiles from: $(pwd)"

# Stow each package
echo "Stowing nvim..."
stow -t ~ nvim

echo "Stowing tmux..."
stow -t ~ tmux

echo "Dotfiles setup complete!"

