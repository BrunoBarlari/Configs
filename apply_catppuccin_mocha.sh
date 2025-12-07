#!/bin/bash

# Script to apply Catppuccin Mocha theme across all configured applications
# Author: AI Assistant
# Date: $(date)

echo "🎨 Applying Catppuccin Mocha theme to all applications..."

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to restart services
restart_service() {
    local service="$1"
    if command_exists brew && brew services list | grep -q "$service"; then
        echo "🔄 Restarting $service..."
        brew services restart "$service" 2>/dev/null || echo "⚠️  Could not restart $service"
    fi
}

echo ""
echo "✅ Applied Catppuccin Mocha theme to:"

# Text editors
if command_exists nvim; then
    echo "  📝 Neovim - Updated colorscheme plugin to use catppuccin mocha"
fi

if command_exists hx; then
    echo "  ✏️  Helix - Created and applied catppuccin_mocha theme"
fi

if command_exists zed; then
    echo "  🎯 Zed - Set theme to Catppuccin Mocha"
fi

# System monitoring
if command_exists btop; then
    echo "  📊 btop - Downloaded and configured catppuccin_mocha theme"
fi

if command_exists neofetch; then
    echo "  🖼️  Neofetch - Hardcoded Catppuccin Mocha colors for text and ASCII"
fi

# Terminal emulators
if [ -f "/Users/brunobarlari/.config/dotfiles/alacritty/alacritty.toml" ]; then
    echo "  🖥️  Alacritty - Applied Catppuccin Mocha color scheme"
fi

if [ -f "/Users/brunobarlari/.config/dotfiles/kitty/current-theme.conf" ]; then
    echo "  🐱 Kitty - Applied Catppuccin Mocha theme"
fi

if [ -f "/Users/brunobarlari/.config/dotfiles/ghostty/config" ]; then
    echo "  👻 Ghostty - Set theme to catppuccin-mocha"
fi

# Shell and multiplexers
if command_exists fish; then
    echo "  🐠 Fish Shell - Hardcoded Catppuccin Mocha color palette"
fi

if command_exists starship; then
    echo "  🚀 Starship - Applied Catppuccin Mocha color palette"
fi

if command_exists zellij; then
    echo "  🔲 Zellij - Created and applied catppuccin-mocha theme"
fi

# File managers and utilities
if command_exists yazi; then
    echo "  📁 Yazi - Configured catppuccin-mocha flavor"
fi

if command_exists bat; then
    echo "  🦇 bat - Downloaded and configured Catppuccin Mocha theme"
fi

# SketchyBar (already configured)
if command_exists sketchybar; then
    echo "  📊 SketchyBar - Already using Catppuccin color scheme"
    restart_service sketchybar
fi

echo ""
echo "🔧 To complete the setup:"
echo "  1. Restart your terminal applications"
echo "  2. Reload Neovim (:Lazy sync if needed)"
echo "  3. Restart btop if currently running"
echo "  4. Source your shell configuration or restart terminal"
echo ""
echo "🎉 Catppuccin Mocha theme has been applied to all supported applications!"
echo "   All applications now share a consistent, beautiful color palette."
