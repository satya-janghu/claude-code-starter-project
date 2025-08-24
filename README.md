# Claude Code Starter Setup Script

An interactive bash script that creates a complete Claude Code project starter with curated agents, commands, and optional MCP servers.

## What This Does

1. **Copies a curated starter template** with:
   - Memory bank system (`CLAUDE.md`, pattern templates)
   - 4 specialized agents for enhanced workflows
   - 15+ curated slash commands (excluding security-specific ones)
   - Pre-configured Claude Code settings

2. **Optionally installs MCP servers**:
   - **Context7** - Real-time library documentation
   - **Playwright** - Browser automation via accessibility tree
   - **Serena** - Semantic code analysis using language servers  
   - **Zen** - AI orchestration with multi-model workflows

## Quick Start

### Prerequisites
- **Python 3.10+** and **UV/UVX** (for MCP servers)
- **Claude Code** installed and configured
- **Git** (for cloning)

### Run the Script

```bash
curl -fsSL https://raw.githubusercontent.com/satya-janghu/claude-code-starter-project/main/setup-claude-project.sh | bash
```

Or clone and run locally:
```bash
git clone https://github.com/satya-janghu/claude-code-starter-project.git
cd claude-code-starter-project
./setup-claude-project.sh
```

### What Happens
1. **System check** - Verifies Python 3.10+ and uvx are installed
2. **Template setup** - Copies starter files to current directory
3. **Interactive MCP installation** - Choose which servers to install:
   - Context7 (optional API key for higher rate limits)
   - Playwright (browser automation)
   - Serena (semantic code analysis) 
   - Zen (AI orchestration with Gemini API key)

## MCP Server Details

### Context7
- **Purpose**: Up-to-date library documentation
- **Usage**: Add `use context7` to prompts
- **API Key**: Optional (higher rate limits with key)
- **Learn more**: [Context7 MCP](https://github.com/upstash/context7)

### Playwright  
- **Purpose**: Browser automation without screenshots
- **Usage**: Direct browser commands
- **Requirements**: Node.js (auto-installed with uvx)
- **Learn more**: [Playwright MCP](https://github.com/microsoft/playwright-mcp)

### Serena
- **Purpose**: Semantic code operations via language servers
- **Usage**: Auto-activated for current project
- **Features**: `find_symbol`, `find_referencing_symbols`, symbol navigation
- **Learn more**: [Serena MCP](https://github.com/oraios/serena)

### Zen
- **Purpose**: Multi-model AI collaboration
- **Usage**: Orchestrate tasks across different AI models
- **Requirements**: Gemini API key
- **Features**: `codereview`, `debug`, `planner`, multi-model consensus
- **Learn more**: [Zen MCP Server](https://github.com/BeehiveInnovations/zen-mcp-server)

## Included Tools & Commands

### Specialized Agents
- **`memory-bank-synchronizer`** - Keeps documentation in sync with code
- **`code-searcher`** - Efficient codebase search with CoD (Chain of Draft) mode
- **`get-current-datetime`** - Brisbane timezone utilities  
- **`ux-design-expert`** - Tailwind CSS + Highcharts design guidance

### Key Slash Commands
- **`/update-memory-bank`** - Refresh memory bank files
- **`/cleanup-context`** - Reduce token usage in documentation
- **`/check-best-practices`** - Code quality analysis
- **`/refactor-code`** - Generate refactoring plans
- **`/create-readme-section`** - Generate README sections
- **`/ccusage-daily`** - Usage cost analysis
- **`/apply-thinking-to`** - Enhanced prompt engineering
- **`/convert-to-todowrite-tasklist-prompt`** - Workflow optimization
- **`/batch-operations-prompt`** - Parallel operation optimization
- **`/convert-to-test-driven-prompt`** - TDD-style prompts
- **`/explain-architecture-pattern`** - Architecture insights

## After Setup

1. **Launch Claude Code** in your project directory
2. **Run `/init`** to analyze your codebase and populate memory bank
3. **Try the included tools**:
   - Use agents: "Use code-searcher to find authentication logic"
   - Try commands: `/cleanup-context` or `/check-best-practices`
4. **Customize templates**:
   - Edit `CLAUDE.md` project overview section
   - Update `CLAUDE-patterns.md` with your code conventions
   - Add decisions to `CLAUDE-decisions.md`
5. **Start coding** with enhanced AI assistance!

## File Structure Created

```
your-project/
├── README.md              # Template documentation
├── CLAUDE.md             # AI guidance & MCP usage
├── CLAUDE-patterns.md    # Code patterns template
├── CLAUDE-decisions.md   # Architecture decisions template  
├── CLAUDE-activeContext.md # Session state template
├── LICENSE               # MIT license
└── .claude/
    ├── settings.json     # Basic Claude Code config
    ├── settings.local.json # Permissions & environment
    ├── agents/           # 4 specialized agents
    └── commands/         # Organized slash commands
```

## Troubleshooting

### Missing Dependencies
```bash
# Install UV/UVX
curl -LsSf https://astral.sh/uv/install.sh | sh

# Verify Python version
python3 --version  # Should be 3.10+
```

### MCP Server Issues
- Ensure API keys are correctly entered
- Check Claude Code MCP configuration: `claude mcp list`
- Restart Claude Code after MCP installation

### Permissions
- Script removes `.claude/settings.json` on non-macOS systems (terminal-notifier dependency)
- MCP permissions are pre-configured for the 4 included servers

## Customization

The starter template is designed to be customized:
- **Update `CLAUDE.md`** with project-specific guidance
- **Modify templates** in `CLAUDE-*.md` files  
- **Adjust `.claude/settings.local.json`** permissions as needed
- **Add/remove slash commands** in `.claude/commands/`

## What's Included vs. Excluded

### ✅ Included
- Memory bank system for AI context management
- 4 general-purpose agents (code-searcher, memory-bank, datetime, UX)
- Essential commands (anthropic, cleanup, documentation, refactor, etc.)
- MCP server integration for enhanced capabilities

### ❌ Excluded  
- Security-specific commands and agents
- Tool-specific configurations (Cline, Docker references)
- Outdated MCP server references

## Credits & Inspiration

This project builds upon and extends the excellent work from:
- **[Claude Starter Project Setting](https://github.com/centminmod/my-claude-code-setup)** by [@centminmod](https://github.com/centminmod) - Original inspiration and base template for Claude Code setup

### What I Added
- Interactive MCP server installation script
- Curated selection of 4 modern MCP servers (Context7, Playwright, Serena, Zen)
- Comprehensive memory bank templates
- Cleaned configuration (removed security-specific tools for general use)
- Enhanced documentation for AI agent workflows

### What I Kept
- Memory bank system concept and structure  
- Useful agents (code-searcher, memory-bank-synchronizer, etc.)
- Essential slash commands for productivity
- Claude Code configuration patterns

## Contributing

This is a curated starter focused on Claude Code compatibility and general-purpose AI development workflows. The template balances immediate utility with customization flexibility.

---

**💡 Tip**: After setup, ask Claude to "read the initial instructions" or run specific slash commands to explore the enhanced capabilities!