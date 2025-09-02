# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Overview

This is a comprehensive macOS dotfiles configuration repository containing configuration files and setups for various development tools and applications. The repository is organized by application/tool, with each directory containing specific configurations.

## Key Components

### Karabiner Elements Configuration
- **Location**: `karabiner/`
- **Language**: TypeScript 
- **Description**: Type-safe keyboard customization using Karabiner Elements
- **Key Files**: `rules.ts`, `utils.ts`, `types.ts`

### Neovim Configuration  
- **Location**: `nvim/`
- **Language**: Lua
- **Description**: LazyVim-based Neovim setup with custom plugins and configurations
- **Key Files**: `init.lua`, `lua/config/`, `lua/plugins/`

### Fish Shell Configuration
- **Location**: `fish/`
- **Description**: Fish shell configuration with aliases, environment variables, and OS-specific settings
- **Key Files**: `config.fish`, `config-osx.fish`

### Window Management
- **Location**: `aerospace/`
- **Description**: AeroSpace tiling window manager configuration for macOS
- **Key File**: `aerospace.toml`

### Terminal Tools
- **Atuin**: Shell history sync and search (`atuin/config.toml`)
- **Btop**: System monitoring tool configuration (`btop/btop.conf`)

## Common Development Commands

### Karabiner Configuration
```bash
# Navigate to karabiner directory
cd karabiner

# Install dependencies (one-time setup)
yarn install

# Build configuration from TypeScript
yarn run build

# Watch for changes and rebuild automatically
yarn run watch

# Restart Karabiner service after changes
launchctl kickstart -k gui/`id -u`/org.pqrs.karabiner.karabiner_console_user_server
```

### Neovim Configuration
```bash
# Open Neovim with LazyVim
nvim

# LazyVim will automatically install/update plugins on first run
# To manually sync plugins, use :Lazy in Neovim
```

### Fish Shell Configuration
```bash
# Reload fish configuration
source ~/.config/fish/config.fish

# The configuration automatically loads OS-specific settings and tools like:
# - Atuin (shell history)
# - FZF (fuzzy finder)
# - Eza (ls replacement)
```

## Architecture Overview

### Configuration Management Structure
- **Modular Design**: Each application has its own directory with isolated configurations
- **OS-Specific Handling**: Fish shell configuration includes OS detection and conditional loading
- **Type Safety**: Karabiner configuration uses TypeScript for maintainable keyboard mappings
- **Plugin Architecture**: Neovim uses LazyVim plugin manager for extensible functionality

### Key Architectural Patterns

#### Karabiner (Keyboard Customization)
- **Hyper Key System**: Caps Lock is remapped to a "Hyper" key (Ctrl+Cmd+Alt+Shift) 
- **Layered Commands**: Uses sublayers for organized key mappings (e.g., spacebar layer for app launching)
- **Type-Safe Configuration**: Custom TypeScript types ensure valid Karabiner JSON generation
- **Utility Functions**: Reusable functions for common actions (open apps, shell commands, window management)

#### Neovim Configuration
- **LazyVim Base**: Built on LazyVim distribution for sensible defaults
- **Plugin Customization**: Custom plugins for Go development, formatting (conform.lua), and GitHub Copilot
- **Modular Structure**: Separate files for different concerns (options, keymaps, plugins)

#### Shell Environment
- **Cross-Platform**: Fish configuration with OS-specific modules
- **Tool Integration**: Seamless integration with modern CLI tools (eza, fzf, atuin)
- **Environment Management**: Path configuration for Go, Node.js, and local binaries

### Development Workflow Integration
- **Keyboard-Driven**: Karabiner provides system-wide keyboard shortcuts for launching applications
- **Terminal-Centric**: Fish shell with enhanced history and navigation
- **Editor Integration**: Neovim configured for Go development with LSP, formatting, and AI assistance

## Important Configuration Details

### Karabiner Hyper Key Mappings
- **Spacebar Layer**: Application launching (k=Warp, j=Safari, i=VS Code, etc.)
- **S Layer**: Web browsing shortcuts (k=Twitter, t=YouTube, r=Perplexity)

### Development Tools Setup
- **Go Development**: Neovim configured with gopls LSP, gofumpt formatting
- **YAML Formatting**: Custom yamlfmt configuration for Kubernetes-friendly formatting
- **Shell History**: Atuin for synchronized command history across sessions

### AeroSpace Window Management
- **Dvorak Keyboard Layout**: Configured for Dvorak users
- **Tiling Windows**: Automatic window arrangement with custom gaps
- **Workspace Management**: Multiple workspaces with keyboard shortcuts

This configuration provides a cohesive development environment optimized for macOS with strong keyboard-driven workflows and modern terminal tooling.
