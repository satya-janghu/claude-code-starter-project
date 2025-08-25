#!/bin/bash

set -e

# Repository URL
REPO_URL="https://github.com/satya-janghu/claude-code-starter-project.git"
REPO_NAME="claude-code-starter-project"
PROJECT_DIR="$(pwd)"
STATE_FILE=".claude-setup-state"
BACKUP_DIR=".claude-backup-$(date +%Y%m%d-%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() { echo -e "${BLUE}ℹ${NC} $1"; }
log_success() { echo -e "${GREEN}✓${NC} $1"; }
log_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
log_error() { echo -e "${RED}✗${NC} $1"; }

# State management functions
load_state() {
    if [[ -f "$STATE_FILE" ]]; then
        source "$STATE_FILE"
        log_info "Loaded existing installation state"
    else
        # Initialize default state
        SETUP_VERSION=""
        TEMPLATE_INSTALLED="false"
        CONTEXT7_INSTALLED="false"
        PLAYWRIGHT_INSTALLED="false"
        SERENA_INSTALLED="false"
        ZEN_INSTALLED="false"
        LAST_UPDATE=""
    fi
}

save_state() {
    cat > "$STATE_FILE" << EOF
SETUP_VERSION="2.0"
TEMPLATE_INSTALLED="$TEMPLATE_INSTALLED"
CONTEXT7_INSTALLED="$CONTEXT7_INSTALLED"
PLAYWRIGHT_INSTALLED="$PLAYWRIGHT_INSTALLED"
SERENA_INSTALLED="$SERENA_INSTALLED"
ZEN_INSTALLED="$ZEN_INSTALLED"
LAST_UPDATE="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
EOF
    log_info "State saved"
}

# File preservation functions
is_template_file() {
    local file="$1"
    # Check if file is the default template (has template markers)
    if [[ -f "$file" ]] && grep -q "⚠️ TEMPLATE NOTICE" "$file" 2>/dev/null; then
        return 0  # Is template
    fi
    return 1  # Is customized
}

should_preserve_file() {
    local file="$1"
    
    # Critical files that should be preserved if they exist and are customized
    case "$file" in
        "CLAUDE.md"|"CLAUDE-patterns.md"|"CLAUDE-decisions.md"|"CLAUDE-activeContext.md"|"CLAUDE-troubleshooting.md"|"CLAUDE-config-variables.md")
            if [[ -f "$file" ]] && ! is_template_file "$file"; then
                return 0  # Preserve
            fi
            ;;
        "README.md")
            if [[ -f "$file" ]] && ! is_template_file "$file"; then
                return 0  # Preserve
            fi
            ;;
    esac
    return 1  # Don't preserve
}

backup_file() {
    local file="$1"
    if [[ -f "$file" ]]; then
        mkdir -p "$BACKUP_DIR"
        cp "$file" "$BACKUP_DIR/"
        log_info "Backed up $file"
    fi
}

# System validation functions
check_prerequisites() {
    log_info "Checking system requirements..."
    
    # Check Python version
    if ! command -v python3 >/dev/null 2>&1; then
        log_error "Python 3 is not installed. Please install Python 3.10 or higher."
        return 1
    fi
    
    PYTHON_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
    REQUIRED_VERSION="3.10"
    
    if [[ $(echo "$PYTHON_VERSION $REQUIRED_VERSION" | awk '{print ($1 < $2)}') -eq 1 ]]; then
        log_error "Python version $PYTHON_VERSION found, but Python 3.10 or higher is required."
        return 1
    fi
    
    # Check for UV/UVX
    if ! command -v uvx >/dev/null 2>&1; then
        log_error "uvx is not installed. Please install UV/UVX."
        log_info "You can install it with: curl -LsSf https://astral.sh/uv/install.sh | sh"
        return 1
    fi
    
    log_success "Python $PYTHON_VERSION found"
    log_success "uvx found"
    return 0
}

# MCP validation functions
validate_context7() {
    if command -v claude >/dev/null 2>&1; then
        if claude mcp list 2>/dev/null | grep -q "context7"; then
            return 0
        fi
    fi
    return 1
}

validate_playwright() {
    if command -v claude >/dev/null 2>&1; then
        if claude mcp list 2>/dev/null | grep -q "playwright"; then
            return 0
        fi
    fi
    return 1
}

validate_serena() {
    if command -v claude >/dev/null 2>&1; then
        if claude mcp list 2>/dev/null | grep -q "serena"; then
            return 0
        fi
    fi
    return 1
}

validate_zen() {
    if [[ -f ".mcp.json" ]] && grep -q "zen" ".mcp.json"; then
        return 0
    fi
    return 1
}

# Installation functions
install_template() {
    if [[ "$TEMPLATE_INSTALLED" == "true" ]]; then
        log_info "Template already installed, checking for updates..."
    else
        log_info "Installing template files..."
    fi
    
    # Download template
    log_info "Downloading starter template..."
    rm -rf "$REPO_NAME" 2>/dev/null || true
    
    if ! git clone "$REPO_URL" "$REPO_NAME" 2>/dev/null; then
        log_error "Failed to download starter template from $REPO_URL"
        return 1
    fi
    
    # Process files selectively
    cd "$REPO_NAME/starter"
    
    # Handle critical files with preservation logic
    for file in CLAUDE.md CLAUDE-*.md README.md; do
        if [[ -f "$file" ]]; then
            if should_preserve_file "$file"; then
                log_warning "Preserving existing $file (appears customized)"
            else
                log_info "Updating $file"
                backup_file "$PROJECT_DIR/$file"
                cp "$file" "$PROJECT_DIR/"
            fi
        fi
    done
    
    # Always update template files (agents, commands, basic settings)
    log_info "Updating .claude directory..."
    if [[ -d "$PROJECT_DIR/.claude" ]]; then
        backup_file "$PROJECT_DIR/.claude"
    fi
    
    # Copy .claude structure
    cp -r .claude "$PROJECT_DIR/" 2>/dev/null || true
    
    # Handle settings.local.json specially (merge permissions)
    if [[ -f "$PROJECT_DIR/.claude/settings.local.json" ]] && [[ -f "$PROJECT_DIR/$BACKUP_DIR/.claude/settings.local.json" ]]; then
        log_info "Merging settings.local.json permissions..."
        # Keep existing file but ensure MCP permissions are present
        # This would need jq for proper merging, for now we'll preserve existing
        cp "$PROJECT_DIR/$BACKUP_DIR/.claude/settings.local.json" "$PROJECT_DIR/.claude/settings.local.json"
    fi
    
    # Copy other files that don't exist
    for file in LICENSE; do
        if [[ -f "$file" ]] && [[ ! -f "$PROJECT_DIR/$file" ]]; then
            cp "$file" "$PROJECT_DIR/"
        fi
    done
    
    # Clean up
    cd "$PROJECT_DIR"
    rm -rf "$REPO_NAME"
    
    # Remove settings.json on non-macOS systems
    if [[ "$(uname)" != "Darwin" ]] && [[ -f ".claude/settings.json" ]]; then
        rm ".claude/settings.json"
        log_success "Removed settings.json (terminal-notifier not available on non-macOS)"
    fi
    
    TEMPLATE_INSTALLED="true"
    save_state
    log_success "Template installation completed"
    return 0
}

install_context7() {
    if validate_context7; then
        log_success "Context7 MCP server already installed and working"
        CONTEXT7_INSTALLED="true"
        save_state
        return 0
    fi
    
    log_info "Installing Context7 MCP server..."
    
    # Check if we need to ask for API key
    local api_key=""
    if [[ -z "$CONTEXT7_API_KEY" ]]; then
        echo "Enter your Context7 API key (optional - press Enter to skip for lower rate limits):"
        read -r api_key
    else
        api_key="$CONTEXT7_API_KEY"
    fi
    
    if [[ -n "$api_key" ]]; then
        if claude mcp add --transport http context7 https://mcp.context7.com/mcp --header "CONTEXT7_API_KEY: $api_key"; then
            log_success "Context7 MCP server installed with API key"
            CONTEXT7_INSTALLED="true"
            save_state
            return 0
        else
            log_error "Failed to install Context7 with API key"
            return 1
        fi
    else
        if claude mcp add --transport http context7 https://mcp.context7.com/mcp; then
            log_success "Context7 MCP server installed (rate limited)"
            CONTEXT7_INSTALLED="true"
            save_state
            return 0
        else
            log_error "Failed to install Context7"
            return 1
        fi
    fi
}

install_playwright() {
    if validate_playwright; then
        log_success "Playwright MCP server already installed and working"
        PLAYWRIGHT_INSTALLED="true"
        save_state
        return 0
    fi
    
    log_info "Installing Playwright MCP server..."
    if claude mcp add playwright npx @playwright/mcp@latest; then
        log_success "Playwright MCP server installed"
        PLAYWRIGHT_INSTALLED="true"
        save_state
        return 0
    else
        log_error "Failed to install Playwright"
        return 1
    fi
}

install_serena() {
    if validate_serena; then
        log_success "Serena MCP server already installed and working"
        SERENA_INSTALLED="true"
        save_state
        return 0
    fi
    
    log_info "Installing Serena MCP server..."
    if claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant --project "$(pwd)"; then
        log_success "Serena MCP server installed"
        SERENA_INSTALLED="true"
        save_state
        return 0
    else
        log_error "Failed to install Serena"
        return 1
    fi
}

install_zen() {
    if validate_zen; then
        log_success "Zen MCP server already installed and working"
        ZEN_INSTALLED="true"
        save_state
        return 0
    fi
    
    log_info "Installing Zen MCP server..."
    
    # Check if we need to ask for API key
    local api_key=""
    if [[ -z "$GEMINI_API_KEY" ]]; then
        echo "Please enter your Gemini API key:"
        read -r api_key
    else
        api_key="$GEMINI_API_KEY"
    fi
    
    if [[ -z "$api_key" ]]; then
        log_error "API key cannot be empty. Skipping Zen installation."
        return 1
    fi
    
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
        "GEMINI_API_KEY": "$api_key"
      }
    }
  }
}
EOF
    
    # Merge with existing .mcp.json
    if command -v jq >/dev/null 2>&1; then
        if jq -s '.[0] * .[1]' .mcp.json temp_zen_config.json > .mcp.json.tmp; then
            mv .mcp.json.tmp .mcp.json
            rm -f temp_zen_config.json
            log_success "Zen MCP server installed"
            ZEN_INSTALLED="true"
            save_state
            return 0
        else
            log_error "Failed to merge Zen configuration"
            rm -f temp_zen_config.json .mcp.json.tmp
            return 1
        fi
    else
        mv temp_zen_config.json .mcp.json
        log_warning "jq not found, replaced entire .mcp.json file"
        log_success "Zen MCP server installed"
        ZEN_INSTALLED="true"
        save_state
        return 0
    fi
}

# Interactive installation functions
prompt_mcp_installation() {
    local server_name="$1"
    local install_function="$2"
    local current_state="$3"
    
    if [[ "$current_state" == "true" ]]; then
        echo "Would you like to reinstall/repair the $server_name MCP server? (y/n)"
    else
        echo "Would you like to install the $server_name MCP server? (y/n)"
    fi
    
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        if $install_function; then
            return 0
        else
            log_error "Failed to install $server_name"
            return 1
        fi
    else
        log_info "Skipping $server_name MCP server installation"
        return 0
    fi
}

# Main execution
main() {
    echo "===========================================" 
    echo "Claude Code Starter Project Setup Script"
    echo "=========================================="
    echo
    
    # Load existing state
    load_state
    
    if [[ -n "$SETUP_VERSION" ]]; then
        log_info "Existing installation detected (version $SETUP_VERSION)"
        log_info "Last updated: $LAST_UPDATE"
        echo
        echo "This script can:"
        echo "  • Update template files and agents"
        echo "  • Repair or reinstall MCP servers"  
        echo "  • Preserve your customized files"
        echo
        echo "Continue? (y/n)"
        read -r continue_setup
        if [[ ! "$continue_setup" =~ ^[Yy]$ ]]; then
            log_info "Setup cancelled"
            exit 0
        fi
    fi
    
    # Check prerequisites
    if ! check_prerequisites; then
        exit 1
    fi
    
    echo
    
    # Install/update template
    if ! install_template; then
        log_error "Template installation failed"
        exit 1
    fi
    
    echo
    log_info "Template installation complete!"
    echo
    
    # MCP server installations
    log_info "MCP Server Setup:"
    echo
    
    # Context7
    if ! prompt_mcp_installation "Context7" "install_context7" "$CONTEXT7_INSTALLED"; then
        log_warning "Context7 installation failed, continuing..."
    fi
    
    echo
    
    # Playwright  
    if ! prompt_mcp_installation "Playwright" "install_playwright" "$PLAYWRIGHT_INSTALLED"; then
        log_warning "Playwright installation failed, continuing..."
    fi
    
    echo
    
    # Serena
    if ! prompt_mcp_installation "Serena" "install_serena" "$SERENA_INSTALLED"; then
        log_warning "Serena installation failed, continuing..."
    fi
    
    echo
    
    # Zen
    if ! prompt_mcp_installation "Zen" "install_zen" "$ZEN_INSTALLED"; then
        log_warning "Zen installation failed, continuing..."
    fi
    
    # Final state save
    save_state
    
    echo
    echo "===========================================" 
    log_success "Setup completed successfully!"
    echo "==========================================="
    echo
    echo "Next steps:"
    echo "1. Launch Claude Code in this directory"
    echo "2. Run '/init' to analyze your codebase"
    echo "3. Try the included agents and commands"
    echo
    if [[ -d "$BACKUP_DIR" ]]; then
        echo "Backups stored in: $BACKUP_DIR"
    fi
    echo "Installation state tracked in: $STATE_FILE"
    echo
}

# Run main function
main "$@"