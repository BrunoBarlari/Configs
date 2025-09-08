#!/bin/bash

# Setup script for GitHub CLI integration with SketchyBar

echo "🔧 Setting up GitHub CLI for SketchyBar git status..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew is required but not installed. Please install Homebrew first."
    exit 1
fi

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "📦 Installing GitHub CLI..."
    brew install gh
else
    echo "✅ GitHub CLI is already installed"
fi

# Check if jq is installed (needed for JSON parsing)
if ! command -v jq &> /dev/null; then
    echo "📦 Installing jq (JSON processor)..."
    brew install jq
else
    echo "✅ jq is already installed"
fi

# Check if gh is authenticated
if ! gh auth status &> /dev/null; then
    echo "🔐 GitHub CLI is not authenticated. Please run:"
    echo "    gh auth login"
    echo ""
    echo "Choose 'GitHub.com' and follow the prompts to authenticate."
    echo "After authentication, restart SketchyBar with: brew services restart sketchybar"
else
    echo "✅ GitHub CLI is authenticated"
fi

echo ""
echo "🎉 Setup complete! The git status plugin will show:"
echo "   • Pull requests assigned to you"
echo "   • Issues created by you"
echo "   • GitHub notifications"
echo ""
echo "Click the git icon to open GitHub notifications in your browser."
echo "Hover over the git icon to see detailed notification list."

