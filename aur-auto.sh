#!/bin/bash

# aur-auto.sh - Modern AUR auto installer
# 🐳 Whale Lab | Script by dev whale

set -euo pipefail

# Cleanup function
cleanup() {
    [[ -n "${TMPDIR:-}" && -d "$TMPDIR" ]] && rm -rf "$TMPDIR"
}
trap cleanup EXIT

# Check prerequisites
for cmd in git curl makepkg pacman jq fzf; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: $cmd is not installed. Please install it first."
        exit 1
    fi
done

# Suggested packages
SUGGESTED=("yay" "paru" "google-chrome" "visual-studio-code-bin")

echo "👉 Type package name(s) or leave blank for suggested defaults."
echo "   You can also search interactively using fuzzy search!"
read -rp "Packages: " -a PACKAGES

# If user input empty, use suggested
if [ ${#PACKAGES[@]} -eq 0 ]; then
    echo "⚡ No input. Using suggested: ${SUGGESTED[*]}"
    PACKAGES=("${SUGGESTED[@]}")
fi

# Detect AUR helper
if command -v yay &>/dev/null; then
    HELPER="yay"
elif command -v paru &>/dev/null; then
    HELPER="paru"
else
    HELPER=""
fi

# Update system
echo "🔄 Updating system..."
sudo pacman -Syu --noconfirm

# Function to search and select package via fzf
search_package() {
    QUERY="$1"
    echo "🔍 Searching AUR for '$QUERY'..."
    RESULTS=$(curl -s "https://aur.archlinux.org/rpc/?v=5&type=search&arg=$QUERY" | jq -r '.results[] | "\(.Name)\t\(.Version)\t\(.Maintainer)\t\(.Description)"')

    if [ -z "$RESULTS" ]; then
        echo "❌ No results for '$QUERY'"
        return 1
    fi

    SELECTED=$(echo "$RESULTS" | fzf --with-nth=1.. --delimiter="\t" --prompt="Select package> " | cut -f1)
    echo "$SELECTED"
}

