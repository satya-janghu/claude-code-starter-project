#!/bin/bash

set -e

# Repository URL (will be updated with actual GitHub repo)
REPO_URL="https://github.com/satya-janghu/claude-code-starter-project.git"
REPO_NAME="claude-code-starter-project"
PROJECT_DIR="$(pwd)"

# Check system requirements
echo "Checking system requirements..."

# Check Python version
if ! command -v python3 >/dev/null 2>&1; then
    echo "Error: Python 3 is not installed. Please install Python 3.10 or higher."
    exit 1
fi

PYTHON_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
REQUIRED_VERSION="3.10"

if [[ $(echo "$PYTHON_VERSION $REQUIRED_VERSION" | awk '{print ($1 < $2)}') -eq 1 ]]; then
    echo "Error: Python version $PYTHON_VERSION found, but Python 3.10 or higher is required."
    echo "Please install Python 3.10 or higher and try again."
    exit 1
fi

# Check for UV/UVX
if ! command -v uvx >/dev/null 2>&1; then
    echo "Error: uvx is not installed. Please install UV/UVX."
    echo "You can install it with: curl -LsSf https://astral.sh/uv/install.sh | sh"
    exit 1
fi

echo "✓ Python $PYTHON_VERSION found"
echo "✓ uvx found"
echo

# Check for existing Claude starter files to prevent conflicts
echo "Checking for existing files..."
if [[ -f "CLAUDE.md" ]] || [[ -d ".claude" ]] || [[ -f "CLAUDE-patterns.md" ]] || [[ -f "CLAUDE-decisions.md" ]]; then
    echo "⚠️  Error: Claude starter files already exist in this directory."
    echo "This script would overwrite existing files:"
    [[ -f "CLAUDE.md" ]] && echo "  - CLAUDE.md"
    [[ -d ".claude" ]] && echo "  - .claude/"
    [[ -f "CLAUDE-patterns.md" ]] && echo "  - CLAUDE-patterns.md"
    [[ -f "CLAUDE-decisions.md" ]] && echo "  - CLAUDE-decisions.md"
    echo
    echo "Please run this script in an empty directory or remove existing Claude files first."
    exit 1
fi

echo "✓ No conflicts found"
echo

# Clone the repository
echo "Downloading starter template..."
if ! git clone "$REPO_URL" "$REPO_NAME" 2>/dev/null; then
    echo "Error: Failed to download starter template from $REPO_URL"
    echo "Please check your internet connection and try again."
    exit 1
fi

# Copy contents from starter directory
echo "Setting up project files..."
cd "$REPO_NAME/starter"
cp -r . "$PROJECT_DIR/" 2>/dev/null || true
cp -r .[^.]* "$PROJECT_DIR/" 2>/dev/null || true

# Clean up cloned repository
cd "$PROJECT_DIR"
rm -rf "$REPO_NAME"

echo "✓ Starter template installed successfully"

echo
echo "Would you like to install the Context7 MCP server? (y/n)"
read -r install_context7

if [[ "$install_context7" =~ ^[Yy]$ ]]; then
    echo "Enter your Context7 API key (optional - press Enter to skip for lower rate limits):"
    read -r context7_api_key
    
    echo "Installing Context7 MCP server..."
    cd "$PROJECT_DIR"
    if [[ -n "$context7_api_key" ]]; then
        claude mcp add --transport http context7 https://mcp.context7.com/mcp --header "CONTEXT7_API_KEY: $context7_api_key"
    else
        claude mcp add --transport http context7 https://mcp.context7.com/mcp
    fi
    echo "Context7 MCP server installed successfully."
else
    echo "Skipping Context7 MCP server installation."
fi

echo
echo "Would you like to install the Playwright MCP server? (y/n)"
read -r install_playwright

if [[ "$install_playwright" =~ ^[Yy]$ ]]; then
    echo "Installing Playwright MCP server..."
    cd "$PROJECT_DIR"
    claude mcp add playwright npx @playwright/mcp@latest
    echo "Playwright MCP server installed successfully."
else
    echo "Skipping Playwright MCP server installation."
fi

echo
echo "Would you like to install the Serena MCP server? (y/n)"
read -r install_serena

if [[ "$install_serena" =~ ^[Yy]$ ]]; then
    echo "Installing Serena MCP server..."
    cd "$PROJECT_DIR"
    claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant --project $(pwd)
    echo "Serena MCP server installed successfully."
else
    echo "Skipping Serena MCP server installation."
fi

echo
echo "Would you like to install the Zen MCP server? (y/n)"
read -r install_zen

if [[ "$install_zen" =~ ^[Yy]$ ]]; then
    echo "Please enter your Gemini API key:"
    read -r gemini_api_key
    
    if [[ -n "$gemini_api_key" ]]; then
        echo "Installing Zen MCP server..."
        cd "$PROJECT_DIR"
        
        # Create .mcp.json if it doesn't exist
        if [[ ! -f ".mcp.json" ]]; then
            echo '{"mcpServers":{}}' > .mcp.json
        fi
        
        # Add zen server configuration
        cat > temp_zen_config.json << EOF
{
  "mcpServers": {
    "zen": {
      "command": "uvx",
      "args": ["--from", "git+https://github.com/BeehiveInnovations/zen-mcp-server.git", "zen-mcp-server"],
      "env": {
        "PATH": "/usr/local/bin:/usr/bin:/bin:/opt/homebrew/bin:~/.local/bin",
        "GEMINI_API_KEY": "$gemini_api_key"
      }
    }
  }
}
EOF
        
        # Merge with existing .mcp.json
        if command -v jq >/dev/null 2>&1; then
            jq -s '.[0] * .[1]' .mcp.json temp_zen_config.json > .mcp.json.tmp && mv .mcp.json.tmp .mcp.json
        else
            mv temp_zen_config.json .mcp.json
            echo "Warning: jq not found, replaced entire .mcp.json file"
        fi
        
        rm -f temp_zen_config.json
        echo "Zen MCP server installed successfully."
    else
        echo "API key cannot be empty. Skipping Zen installation."
    fi
else
    echo "Skipping Zen MCP server installation."
fi